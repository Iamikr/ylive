// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoXoMI0suI6Dd6DYwR1sNCm0XP45j2O0U',
    appId: '1:154049945766:web:cd0048d9f58a89f4959467',
    messagingSenderId: '154049945766',
    projectId: 'skincareomr-57f74',
    authDomain: 'skincareomr-57f74.firebaseapp.com',
    storageBucket: 'skincareomr-57f74.appspot.com',
    measurementId: 'G-8HVD9JR4NJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACHWOYgDzD7IdmddAl_e7SRuf5hRhOvUc',
    appId: '1:154049945766:android:818bc6a41d3d45e9959467',
    messagingSenderId: '154049945766',
    projectId: 'skincareomr-57f74',
    storageBucket: 'skincareomr-57f74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJbr2ZNOrvbh-yxMOZ8MjZgjaUkuBpXLc',
    appId: '1:154049945766:ios:37dd40e3a0054451959467',
    messagingSenderId: '154049945766',
    projectId: 'skincareomr-57f74',
    storageBucket: 'skincareomr-57f74.appspot.com',
    androidClientId: '154049945766-v5kredpjs36gp947eqf4qt6ihg615mfg.apps.googleusercontent.com',
    iosClientId: '154049945766-7l36iql6cu6nmv42r2no6ivfjl2v6jt7.apps.googleusercontent.com',
    iosBundleId: 'com.omer.skincare.skincare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJbr2ZNOrvbh-yxMOZ8MjZgjaUkuBpXLc',
    appId: '1:154049945766:ios:e6388df007d75c53959467',
    messagingSenderId: '154049945766',
    projectId: 'skincareomr-57f74',
    storageBucket: 'skincareomr-57f74.appspot.com',
    androidClientId: '154049945766-v5kredpjs36gp947eqf4qt6ihg615mfg.apps.googleusercontent.com',
    iosClientId: '154049945766-fn437igq9cdrcrbt6394gjbvcmonsn4r.apps.googleusercontent.com',
    iosBundleId: 'com.omer.skincare.skincare.RunnerTests',
  );
}
