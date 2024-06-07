import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:skincare/core/utils/colors.dart';
import 'package:skincare/screens/home/home_screen.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_form_field.dart';
import '../../../../constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../../models/api_response.dart';
import '../../../../services/authentication_service.dart';
import '../../../dashboard/dashboard_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController refCodeController = TextEditingController();
  bool remember = false;

  int selectedIndex = -1;
  List<String> containerTexts = ['Father', 'Mother', 'Guardian'];


  String? selectedGender;
  bool _isLoading = false;
  final List<String> errors = [];
  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();

  void addError({required String error}) {
    if (!errors.contains(error)) {
      // Delay the addition of error to the errors list
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) {
          // Check if the widget is still mounted
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
            buildFirstNameFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildLastNameFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildDatePickerFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildDropdownButtonFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildEmailFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildMobileNumberFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildAddressFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildVillageFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildCityFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildDistrictFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildStateFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildNICFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildPasswordFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildConfirmPasswordFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            buildRefCodeFormField(),
            SizedBox(
              height: Get.height * 0.02,
            ),

            Text('Realtion with child', style: AppTextStyles.title,),
            SizedBox(
              height: Get.height * 0.02,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                        left: 10
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: index == selectedIndex
                                ? Colors.blue
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          containerTexts[index],
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                index == selectedIndex ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomButtonWidget(
                buttonColor: AppColors.buttonColor,
                isLoading: _isLoading,
                onTap: () {
                  _signUp();
                },
                buttonText: 'Sign Up'),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ));
  }

  DropdownButtonFormField<String> buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Select Gender',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
      ),
      items: ['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedGender = newValue;
        });
      },
      dropdownColor: AppColors.whiteColor, // Set the dropdown menu color
      style: const TextStyle(
          color: Colors.black), // Set the text color of the selected item
      iconEnabledColor: Colors.blue, // Set the color of the dropdown icon
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a gender';
        }
        return null;
      },
    );
  }

  CustomFormField buildDatePickerFormField() {
    return CustomFormField(
      controller: dob,
      suffixIcon: Icon(
        Icons.calendar_month,
        color: AppColors.buttonColor,
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            dob.text = "${pickedDate.toLocal()}"
                .split(' ')[0]; // Format the date as needed
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(
              error: kDOBNullError); // Ensure you have a kDateNullError defined
          return "";
        }
        return null;
      },
      hintText: 'Select Date',
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

  CustomFormField buildConfirmPasswordFormField() {
    return CustomFormField(
      controller: password,
      isuffixIconPassword: true,
      hintText: 'Confirm Password ',
      suffixIcon: Icon(Icons.visibility_off),
      onFieldSubmitted: (newValue) => password.text = newValue!,
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

  CustomFormField buildFirstNameFormField() {
    return CustomFormField(
      controller: firstName,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          firstName.text = newValue;
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
      hintText: 'First Name',
    );
  }

  CustomFormField buildLastNameFormField() {
    return CustomFormField(
      controller: lastName,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          lastName.text = newValue;
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
      hintText: 'Last Name',
    );
  }

  CustomFormField buildMobileNumberFormField() {
    return CustomFormField(
      controller: mobileNumberController,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (newValue) {
        setState(() {
          mobileNumberController.text = newValue;
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
      hintText: 'Mobile Number',
    );
  }

  CustomFormField buildAddressFormField() {
    return CustomFormField(
      controller: addressController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          addressController.text = newValue;
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
      hintText: 'Address',
    );
  }

  CustomFormField buildVillageFormField() {
    return CustomFormField(
      controller: villageController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          villageController.text = newValue;
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
      hintText: 'Village',
    );
  }

  CustomFormField buildCityFormField() {
    return CustomFormField(
      controller: cityController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          cityController.text = newValue;
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
      hintText: 'City',
    );
  }

  CustomFormField buildDistrictFormField() {
    return CustomFormField(
      controller: districtController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          districtController.text = newValue;
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
      hintText: 'District',
    );
  }

  CustomFormField buildStateFormField() {
    return CustomFormField(
      controller: stateController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          stateController.text = newValue;
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
      hintText: 'State',
    );
  }

  CustomFormField buildNICFormField() {
    return CustomFormField(
      controller: nicController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          nicController.text = newValue;
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
      hintText: 'NIC',
    );
  }

  CustomFormField buildRefCodeFormField() {
    return CustomFormField(
      controller: refCodeController,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (newValue) {
        setState(() {
          refCodeController.text = newValue;
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
      hintText: 'Referral Code (if any)',
    );
  }

  Future _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final result = await authenticationService.signUpWithEmail(
        email.text, password.text, firstName.text);

    setState(() {
      _isLoading = false;
    });

    if (!result.error) {
      showToast("Login successful");
      Get.to(Dashboard());
    } else {
      var result;
      showToast(result.errorMessage!);
    }
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
