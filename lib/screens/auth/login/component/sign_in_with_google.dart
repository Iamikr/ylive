import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';

class SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: Get.height * 0.07,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.boxColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30, // Adjust the width as needed
              child: Image.asset(
                'assets/images/google.png', // Your Google icon image path
                height: 30,
                width: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Expanded(
                child: Text(
                  'Sign in with Google',
                  style: AppTextStyles.title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
