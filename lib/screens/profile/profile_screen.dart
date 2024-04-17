

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:skincare/screens/profile/profile_controller.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/styles.dart';
import '../../models/api_response.dart';
import '../../services/authentication_service.dart';
import '../auth/login/login_screen.dart';



class ProfileScreen extends StatelessWidget {

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();

  final ProfileController controller = Get.put(ProfileController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return   Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(

        children: [



          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: Get.height * 0.25,
                width: Get.width ,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,

                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(160),
                      bottomRight: Radius.circular(160),
                    )
                ),
              ),
              Positioned(
                bottom: -20,
                right: Get.width * 0.38,
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user?.photoURL ?? 'https://cdn-icons-png.freepik.com/256/3135/3135715.png?semt=ais_hybrid'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.04,),

           Center(child: Text(user?.displayName ?? '', style: AppTextStyles.headlineSmall,)),
          Center(
            child: Text(user?.email ?? '' , style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor.withOpacity(0.5)
            ),),
          ),
          SizedBox(height: Get.height * 0.04,),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: Get.height * 0.08,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                       children: [
                        Image.asset('assets/images/school.png',height: 30 , width: 30,),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Maplewood High \n School', style: AppTextStyles.title,),
                        )

                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: Get.height * 0.08,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/map.png',height: 30 , width: 30,),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Great Falls,\n Maryland', style: AppTextStyles.title,),
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.04,),

          Container(
            height: Get.height * 0.25,
            color: const Color(0xffFFFCEA),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Friends' , style: AppTextStyles.headlineSmall,),
                      Text('See All' , style: AppTextStyles.primaryColorText,),

                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.04,),

                SizedBox(
                  height: Get.height * 0.15,

                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.friendsImages.length,
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10

                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(controller.friendsImages[index]), // Replace this with your image
                              ),
                              SizedBox(height: 10,),
                                Text(controller.friendsNames[index] , style: AppTextStyles.headlineMedium,),

                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.04,),

          ListTile(
            leading: Image.asset('assets/images/editprofile.png', height: 20 ,),
            title: const Text('Edit profile' , style: AppTextStyles.headlineMedium,),

          ),
          Divider(thickness: 1,),
          ListTile(
            leading: Image.asset('assets/images/yearBook.png', height: 20 ,),
            title: const Text('My Year Book' , style: AppTextStyles.headlineMedium,),

          ),
            Divider(thickness: 1,),
          ListTile(
            onTap: (){
              _signOut();
            },
            leading: Image.asset('assets/images/logout.png', height: 20 ,),
            title: const Text('Log Out' , style: AppTextStyles.headlineMedium,),

          ),
          Divider(thickness: 1,),



        ],
      ),
    );
  }
  _signOut() async {


    APIResponse result = await authenticationService.logout();



    if (!result.error) {
      await showToast("Logged out successfully");

      Get.off(LoginScreen());
    } else {
      showToast(result.errorMessage!);
    }
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: AppColors.primaryColor,
        fontSize: 16.0);
  }
}
