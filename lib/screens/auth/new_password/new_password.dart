import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_form_field.dart';
import '../../../constant.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'New Password',
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
            'Enter Your New Password  ',
            style: AppTextStyles.headlineLarge,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          const Text(
            'Please enter your Password here . It  will be set your new password for next time authetication',
            style: AppTextStyles.title,
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          buildConfirmPasswordFormField(),
          SizedBox(
            height: Get.height * 0.2,
          ),
          CustomButtonWidget(
              buttonColor: AppColors.buttonColor,
              onTap: () {
                // Get.to(VerificationScreen());
              },
              buttonText: 'DONE'),
          SizedBox(
            height: Get.height * 0.02,
          ),
        ],
      ),
    );
  }

  CustomFormField buildPasswordFormField() {
    return CustomFormField(
      controller: password,
      isuffixIconPassword: true,
      hintText: 'Enter Password ',
      suffixIcon: Icon(Icons.visibility_off),
      onFieldSubmitted: (newValue) => password.text = newValue!,
      onChange: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          //  removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //  addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          //  addError(error: kShortPassError);
          return "";
        }
        return null;
      },
    );
  }

  CustomFormField buildConfirmPasswordFormField() {
    return CustomFormField(
      controller: password,
      isuffixIconPassword: true,
      hintText: 'Confirm Password ',
      suffixIcon: Icon(Icons.visibility_off),
      onFieldSubmitted: (newValue) => password.text = newValue!,
      onChange: (value) {
        if (value.isNotEmpty) {
          //  removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          // removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //  addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          //  addError(error: kShortPassError);
          return "";
        }
        return null;
      },
    );
  }
}
