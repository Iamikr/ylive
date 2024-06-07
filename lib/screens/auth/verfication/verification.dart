import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/custom_button.dart';
import '../../../core/utils/assets_constant.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../new_password/new_password.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Verify OTP',
          style: AppTextStyles.appBarText,
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 50),
        children: [
           SizedBox(
            height: Get.height * 0.04,
          ),
          Text(
            'Verification Code  ',
            style: AppTextStyles.headlineLarge,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Text(
            'Please confirm the security code received on yur registered email.',
            style: AppTextStyles.title,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          PinCodeTextField(
            appContext: context,
            length: 4,
            onChanged: (value) {
              // Handle OTP input change
            },
            onCompleted: (value) {
              // Handle OTP input completed
            },
            pinTheme: PinTheme(
              inactiveColor: Colors.grey,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight:60,
              fieldWidth: 80,
              activeFillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          CustomButtonWidget(

              buttonColor: AppColors.buttonColor,
              onTap: () {

                Get.to(const NewPasswordScreen());
              }, buttonText: 'Verify'),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: "Didn’t receive the code?",
                  style: AppTextStyles.title,
                  children: [
                    TextSpan(
                      text: " Resend",
                      style: AppTextStyles.title?.copyWith(
                          fontSize: 14, color: AppColors.buttonColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
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
