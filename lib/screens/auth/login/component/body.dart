import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skincare/core/utils/assets_constant.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_form_field.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../signup/signup_screen.dart';
import 'Signin_from.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _BodyState();
}

class _BodyState extends State<SignInBody> {
  bool isChecked = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
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
  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Navigate to the dashboard screen
          showToast("Loged In Successfully");
          Get.to(() => const Dashboard());
        } else {
          // Handle null user
          print('Error: User is null');
        }

        return user;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding:
            const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 50),
        children: [
          SizedBox(
            height: Get.height * 0.06,
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
            child: const Text(
              'Welcome to Vaccination',
              style: AppTextStyles.loginHeadLine,
            ),
          ),






          SizedBox(
            height: Get.height * 0.02,
          ),
          //form
          SignForm(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          const Text(
            'Or Connect With ',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: Get.height * 0.07,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/apple.png',
                        height: 30,
                        width: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Apple',
                          style: AppTextStyles.title,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child:GestureDetector(
                    onTap: () async {

                      await _handleSignIn();

                    },
                    child: Container(
                      height: Get.height * 0.07,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset(
                            'assets/images/google.png',
                            height: 30,
                            width: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Google',
                              style: AppTextStyles.title,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          // end of from

          SizedBox(
            height: Get.height * 0.04,
          ),

          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: "Not Registered ? ",
                  style: AppTextStyles.title,
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: AppTextStyles.title?.copyWith(
                          fontSize: 14, color: AppColors.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(const SignUpScreen());
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
