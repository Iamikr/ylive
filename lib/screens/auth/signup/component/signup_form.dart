import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/core/utils/colors.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_form_field.dart';
import '../../../../constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../dashboard/dashboard_screen.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  bool _isLoading = false;
  final List<String> errors = [];



  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
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
    return _isLoading
        ? const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    )
        :  Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Name',
                style: AppTextStyles.title,
              ),
            ),

            buildNameFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
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

            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomButtonWidget(
                onTap: () {
                  Get.to(() => const Dashboard());
                },
                buttonText: 'Sign Up'),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ));
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
      onFieldSubmitted: (newValue) => email = newValue,
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
  CustomFormField buildNameFormField() {
    return CustomFormField(
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) => email = newValue,
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
      hintText: 'Enter Name',
    );
  }

// _signIn() async {
//   setState(() {
//     _isLoading = true;
//   });
//
//  // final result = await authenticationService.signInWithEmail(email, password);
//
//   setState(() {
//     _isLoading = false;
//   });
//
//   if (!result.error) {
//     showToast("Login successful");
//     Navigator.pushNamed(context, HomeScreen.routeName);
//   } else {
//     showToast(result.errorMessage!);
//   }
// }

// showToast(String msg) {
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.CENTER,
//     textColor: Colors.white,
//     backgroundColor: kPrimaryColor,
//     fontSize: 16.0,
//   );
// }
}
