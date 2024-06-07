


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../components/custom_button.dart';
import '../../components/custom_form_field.dart';
import '../../constant.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/styles.dart';


class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  EditProfileFormState createState() => EditProfileFormState();
}

class EditProfileFormState extends State<EditProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email  = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  bool remember = false;
  bool _isLoading = false;
  final List<String> errors = [];




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
                isLoading: _isLoading,
                onTap: () {


                },
                buttonText: 'Edit'),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ));
  }

  CustomFormField buildPasswordFormField() {
    return CustomFormField(
      controller: password,
      isuffixIconPassword: true,
      hintText: 'Enter Password ',
      suffixIcon: Icon(Icons.visibility_off),

      onFieldSubmitted: (newValue) => password.text = newValue,
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
      controller: email,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (newValue) {
        setState(() {
          email.text = newValue;
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
  CustomFormField buildNameFormField() {
    return CustomFormField(
      controller: name,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          name.text = newValue;
        });


      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      hintText: 'Enter Name',
    );
  }




  showToast(String msg) {
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