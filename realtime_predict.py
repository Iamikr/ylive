#!/usr/bin/env python3
"""Realtime prediction script for attention CNN-LSTM model."""
import os
import sys
import time
import warnings
import joblib
import numpy as np
import pandas as pd
import MetaTrader5 as mt5
import tensorflow as tf
from sklearn.preprocessing import StandardScaler
from ta.momentum import RSIIndicator, ROCIndicator
from ta.volatility import BollingerBands

warnings.filterwarnings("ignore")

# ------------ USER CONFIG ------------
SYMBOLS = ["XAUUSD", "XAUEUR", "XAUAUD"]
TIMEFRAME = mt5.TIMEFRAME_M1
N_BARS = 10000
WINDOW = 30
MODEL_DIR = "saved_attention_models"
MODEL_NAME = None  # set to specific model or use latest automatically
CSV_PATH = "realtime_predictions.csv"

# ------------ HELPER FUNCTIONS ------------

def connect_mt5():
    if not mt5.initialize():
        sys.exit(mt5.last_error())


def fetch(symbol: str) -> pd.DataFrame:
    """Fetch last N_BARS of data for a symbol."""
    r = mt5.copy_rates_from_pos(symbol, TIMEFRAME, 0, N_BARS)
    if r is None or len(r) == 0:
        raise RuntimeError(f"No data for {symbol}")
    df = pd.DataFrame(r)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    df.sort_index(inplace=True)
    renames = {
        'open': f'Open_{symbol}',
        'high': f'High_{symbol}',
        'low': f'Low_{symbol}',
        'close': f'Close_{symbol}',
        'tick_volume': f'Volume_{symbol}'
    }
    return df[list(renames.keys())].rename(columns=renames)


def get_raw_and_features() -> tuple:
    """Return raw price dataframe and computed feature dataframe."""
    dfs = [fetch(s) for s in SYMBOLS]
    raw = (
        pd.concat(dfs, axis=1, join='inner')
        .dropna()
        .reset_index()
        .rename(columns={'time': 'Timestamp'})
    )

    fi = pd.DataFrame(index=raw.index)
    for s in SYMBOLS:
        c = f'Close_{s}'
        fi[f'logret_{c}'] = np.log(raw[c] / raw[c].shift(1))
        fi[f'roc_{c}'] = ROCIndicator(raw[c], 10).roc()
        fi[f'rsi_{c}'] = RSIIndicator(raw[c], 14).rsi()
        bb = BollingerBands(raw[c], 20, 2)
        fi[f'bbh_{c}'] = bb.bollinger_hband()
        fi[f'bbl_{c}'] = bb.bollinger_lband()
    main = SYMBOLS[0]
    fi['hl_pct'] = (raw[f'High_{main}'] - raw[f'Low_{main}']) / raw[f'Low_{main}']
    fi['oc_pct'] = (raw[f'Close_{main}'] - raw[f'Open_{main}']) / raw[f'Open_{main}']
    fi['vol'] = raw[f'Volume_{main}']

    fi = fi.dropna().reset_index(drop=True)
    raw_trim = raw.loc[fi.index].reset_index(drop=True)
    return raw_trim, fi


class Bahdanau(tf.keras.layers.Layer):
    """Attention layer used in the trained model."""
    def __init__(self, units):
        super().__init__()
        self.W1 = tf.keras.layers.Dense(units)
        self.W2 = tf.keras.layers.Dense(units)
        self.V = tf.keras.layers.Dense(1)

    def call(self, q, v):
        q = tf.expand_dims(q, 1)
        score = self.V(tf.nn.tanh(self.W1(v) + self.W2(q)))
        weights = tf.nn.softmax(score, 1)
        return tf.reduce_sum(weights * v, 1)


def load_model_and_scaler():
    """Load the latest model and scaler from MODEL_DIR."""
    if MODEL_NAME:
        model_path = os.path.join(MODEL_DIR, MODEL_NAME)
    else:
        h5_files = [f for f in os.listdir(MODEL_DIR) if f.endswith('.h5')]
        if not h5_files:
            raise FileNotFoundError('No model files found in ' + MODEL_DIR)
        model_path = os.path.join(
            MODEL_DIR,
            max(h5_files, key=lambda f: os.path.getmtime(os.path.join(MODEL_DIR, f)))
        )
    scaler_path = os.path.join(MODEL_DIR, 'scaler.pkl')
    scaler = joblib.load(scaler_path)
    model = tf.keras.models.load_model(model_path, custom_objects={'Bahdanau': Bahdanau})
    return model, scaler


def prepare_latest_sample(raw: pd.DataFrame, fi: pd.DataFrame, scaler: StandardScaler) -> np.ndarray:
    """Prepare a scaled feature sample for the most recent WINDOW data."""
    X_raw = fi.iloc[-WINDOW:].values
    X_raw = np.expand_dims(X_raw, 0)
    X_scaled = scaler.transform(X_raw.reshape(-1, X_raw.shape[-1])).reshape(X_raw.shape)
    return X_scaled


def run_prediction(model, scaler):
    raw, fi = get_raw_and_features()
    X = prepare_latest_sample(raw, fi, scaler)
    pred_prob = model.predict(X, verbose=0)[0]
    pred_class = int(np.argmax(pred_prob))
    timestamp = raw['Timestamp'].iloc[-1]
    df_out = pd.DataFrame([
        {
            'timestamp': timestamp,
            'predicted_class': pred_class,
            'prob_up': pred_prob[0],
            'prob_down': pred_prob[1],
            'prob_neutral': pred_prob[2]
        }
    ])
    write_header = not os.path.exists(CSV_PATH)
    df_out.to_csv(CSV_PATH, mode='a', header=write_header, index=False)
    print(f"{timestamp} -> class {pred_class}")


def wait_for_next_minute():
    now = time.localtime()
    time.sleep(60 - now.tm_sec)


def main_loop(model, scaler):
    print("Starting realtime prediction loop …")
    while True:
        wait_for_next_minute()
        minute = time.localtime().tm_min
        if minute in (1, 2, 3):
            try:
                run_prediction(model, scaler)
            except Exception as e:
                print("Prediction error:", e)


if __name__ == "__main__":
    connect_mt5()
    model, scaler = load_model_and_scaler()
    main_loop(model, scaler)
