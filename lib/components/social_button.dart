// ignore_for_file: file_names


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/colors.dart';
import '../core/utils/styles.dart';

class SocialButton extends StatelessWidget {
  final String status;
  final VoidCallback onTap;
  const SocialButton({super.key, this.status = "GO", required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      color: socialColor(status),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
         children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                socialTitle(status),
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Image.asset(
            socialIcon(status),
            fit: BoxFit.contain,
            height: 20,
          )
        ],
      ),
    );
  }

  String socialTitle(String status) {
    if (status == "GO") {
      return "Google";
    }
    if (status == "FB") {
      return "Continue With Facebook";
    } else {
      return "Apple";
    }
  }

  Color socialColor(String status) {
    return AppColors.boxColor;
  }

  String socialIcon(String status) {
    if (status == "GO") {
      return "assets/images/google.png";
    }
    if (status == "AP") {
      return "assets/images/apple.png";
    } else {
      return "assets/images/apple.png";
    }
  }
}
