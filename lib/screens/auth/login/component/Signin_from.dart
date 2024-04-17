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

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email = "a@a.com";
  late String password = "12345678";
  bool remember = false;
  late bool _isLoading;
  final List<String> errors = [];
  late Future<bool> _signInFuture;

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Email',
              style: AppTextStyles.title,
            ),
          ),
          buildEmailFormField(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Password',
              style: AppTextStyles.title,
            ),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primaryColor,
                    value: remember,
                    onChanged: (value) {
                      // setState(() {
                      //   remember = value!;
                      // });
                    },
                  ),
                  const Text('Remember Me', style: AppTextStyles.title),
                ],
              ),
              GestureDetector(
                onTap: () {
                  //Get.to(const ForgotPasswordScreen());
                },
                child: const Text(
                  'Forgot password',
                  style: AppTextStyles.title,
                ),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomButtonWidget(
            isLoading: _isLoading,
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
      isuffixIconPassword: true,
      hintText: 'Enter Password ',
      suffixIcon: Icon(Icons.visibility_off),

      onFieldSubmitted: (newValue) => password = newValue!,
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
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (newValue) {
        setState(() {
          email = newValue;
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
    setState(() {
      _isLoading = true; // Set loading to true when sign-in starts
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
