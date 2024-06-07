import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:skincare/core/utils/colors.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_form_field.dart';
import '../../../../constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../../services/authentication_service.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../home/home_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../../forgot_password/forgot_password.dart';
import '../../verfication/verification.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late String email = "";
  // late String password = "12345678";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool remember = false;
    bool _isLoading = false;
  final List<String> errors = [];
  late Future<bool> _signInFuture;

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();



  void addError({required String error}) {
    if (!errors.contains(error)) {
      // Delay the addition of error to the errors list
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) { // Check if the widget is still mounted
          setState(() {
            errors.add(error);
          });
        }
      });
    }
  }


  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          buildEmailFormField(),
          SizedBox(
            height: Get.height * 0.02,
          ),

          buildPasswordFormField(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                GestureDetector(
                  onTap: () {
                    Get.to(const ForgotPasswordScreen());
                  },
                  child:   Text(
                    'Forgot password?',
                    style: AppTextStyles.title..copyWith(
                      color: AppColors.buttonColor
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomButtonWidget(
          isLoading: _isLoading,
            buttonColor: AppColors.buttonColor,

            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();


                _signInFuture = _signIn();

              }
            },
            buttonText: 'Sign In',

          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
        ],
      ),
    );
  }

  CustomFormField buildPasswordFormField() {
    return CustomFormField(
      controller: passwordController,
      isuffixIconPassword: true,
      hintText: 'Enter Password ',
      prefixIcon: const Icon(Icons.lock, color: AppColors.buttonColor,),
      suffixIcon: const Icon(Icons.visibility_off,color: AppColors.buttonColor,),

      onFieldSubmitted: (newValue) => passwordController.text = newValue!,
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
    );
  }

  CustomFormField buildEmailFormField() {
    return CustomFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.person_3_outlined, color: AppColors.buttonColor,),
      onFieldSubmitted: (newValue) {
        setState(() {
          emailController.text = newValue;
        });


      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      hintText: 'Enter Email',
    );
  }

  Future<bool> _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      _isLoading = true;
    });


    final result = await authenticationService.signInWithEmail(email, password);
    setState(() {
      _isLoading = false;
    });
    if (!result.error) {
      showToast("Login successful");
      Get.to(() => const Dashboard());
      return true;
    } else {
      showToast(result.errorMessage!);
      return false;
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      fontSize: 16.0,
    );
  }
}
