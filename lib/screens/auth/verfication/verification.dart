//  import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:found_heal/screens/auth/new_password/create_new_password.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../core/utils/assets_constant.dart';
// import '../../../core/utils/colors.dart';
// import '../../../core/utils/styles.dart';
// import '../../../widgets/custom_button.dart';
//
// class VerificationScreen extends StatelessWidget {
//   const VerificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         padding: const EdgeInsets.only(
//             top: 10,
//             right: 20,
//             left: 20,
//             bottom: 50
//         ),
//         children: [
//           Image.asset(AppAssets.textLogo, height: Get.height * 0.03,width: Get.width * 0.4,),
//           SizedBox(height: Get.height * 0.05,),
//           Image.asset(AppAssets.verification,
//             height: Get.height * 0.2,
//             width: Get.width * 0.3,
//           ),
//           SizedBox(height: Get.height * 0.04,),
//           Text('Verification Code  ', style: AppTextStyles.largeBodyText,),
//           SizedBox(height: Get.height * 0.02,),
//             Text('Please confirm the security code received on yur registered email.',
//             style: AppTextStyles.smallText,
//           ),
//           SizedBox(height: Get.height * 0.04,),
//
//           PinCodeTextField(
//             appContext: context,
//
//             length: 6,
//             onChanged: (value) {
//               // Handle OTP input change
//             },
//             onCompleted: (value) {
//               // Handle OTP input completed
//             },
//             pinTheme: PinTheme(
//               inactiveColor: Colors.grey,
//               shape: PinCodeFieldShape.box,
//               borderRadius: BorderRadius.circular(10),
//               fieldHeight: 50,
//               fieldWidth: 40,
//               activeFillColor: Colors.grey[200],
//             ),
//           ),
//
//
//           SizedBox(height: Get.height * 0.06,),
//
//
//
//
//           CustomButtonWidget(
//               onTap: (){
//                 Get.to(CreateNewPassword());
//               },
//               buttonText: 'Verifiy'),
//           SizedBox(height: Get.height * 0.02,),
//           Align(
//             alignment: Alignment.center,
//             child: RichText(
//               text:   TextSpan(
//                   text: "Didn’t receive the code?",
//                   style: AppTextStyles.smallText,
//                   children: [
//                     TextSpan(
//
//                       text: " Resend",style: AppTextStyles.normalText?.copyWith(
//                         fontSize: 14,
//                         color: AppColors.primaryColor
//                     ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//
//                           // Handle sign up action here
//                         },
//
//                     ),
//
//                   ]),
//             ),
//           ),
//
//
//
//
//
//
//
//
//
//
//         ],
//       ),
//     );
//   }
// }
