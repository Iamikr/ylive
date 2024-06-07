

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/core/utils/colors.dart';
import 'package:skincare/core/utils/styles.dart';
import 'package:skincare/screens/auth/verfication/verification.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_form_field.dart';
import '../../../constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text('Forgot Password', style: AppTextStyles.appBarText,),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
            top: 10,
            right: 20,
            left: 20,
            bottom: 50
        ),
        children: [

          SizedBox(height: Get.height * 0.04,),
          Text('Enter Your Email  ', style: AppTextStyles.headlineLarge,),
          SizedBox(height: Get.height * 0.02,),
          Text('Please enter your email here . you will be sent an OTP to verify your email address',
            style: AppTextStyles.title,
          ),
          SizedBox(height: Get.height * 0.06,),



          buildEmailFormField(),

          SizedBox(height: Get.height * 0.2,),




          CustomButtonWidget(
            buttonColor: AppColors.buttonColor,
              onTap: (){
               Get.to(VerificationScreen());
              },
              buttonText: 'Continue'),
          SizedBox(height: Get.height * 0.02,),










        ],
      ),
    );
  }

  CustomFormField buildEmailFormField() {
    return CustomFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email, color: AppColors.buttonColor,),
      onFieldSubmitted: (newValue) {
        setState(() {
          emailController.text = newValue;
        });


      },
      onChange: (value) {
        if (value.isNotEmpty) {
         // removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
         // removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
         // addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          //addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      hintText: 'Enter Email',
    );
  }

}
