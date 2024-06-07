import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/screens/auth/login/component/body.dart';
import 'package:skincare/screens/auth/login/login_screen.dart';
import 'package:skincare/screens/auth/signup/component/signup_form.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_form_field.dart';
import '../../../../core/utils/assets_constant.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../signup/signup_screen.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _BodyState();
}

class _BodyState extends State<SignUpBody> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding:
        const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 50),
        children: [
          SizedBox(
            height: Get.height * 0.04,
          ),


          Center(
            child: SizedBox(
              height: Get.height * 0.2,
              width: Get.width * 0.2,
              child: Image.asset(AppAssets.logo, fit: BoxFit.cover,),
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Center(
            child:   Text(
              'SIGN UP',
              style: AppTextStyles.loginHeadLine.copyWith(
                fontSize: 24
              ),
            ),
          ),
          Center(
            child: Text(
              'PLease enter your information here.',
              style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor.withOpacity(0.5)),
            ),
          ),

          SizedBox(
            height: Get.height * 0.04,
          ),



          SizedBox(
            height: Get.height * 0.02,
          ),
          //form
          const SignUpForm(),

          // end of from

          SizedBox(
            height: Get.height * 0.02,
          ),

          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: "Already have an account ",
                  style: AppTextStyles.title,
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: AppTextStyles.title?.copyWith(
                          fontSize: 14, color: AppColors.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(const LoginScreen());
                          // Handle sign up action here
                        },
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
