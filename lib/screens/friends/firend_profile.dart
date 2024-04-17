

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/screens/profile/profile_controller.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/styles.dart';
import '../auth/login/login_screen.dart';



class FriendProfileScreen extends StatelessWidget {


  const FriendProfileScreen({super.key});



  @override
  Widget build(BuildContext context) {
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
                    backgroundImage:
                    NetworkImage( 'https://cdn-icons-png.freepik.com/256/3135/3135715.png?semt=ais_hybrid'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.04,),

          Center(child: Text(  'John', style: AppTextStyles.headlineSmall,)),
          Center(
            child: Text( 'John@john.comn' , style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor.withOpacity(0.5)
            ),),
          ),
          SizedBox(height: Get.height * 0.02,),

          Center(
            child: Container(
              height: Get.height * 0.06,
              width: Get.width * 0.25,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Follow', style: AppTextStyles.title,),

                ],
              ),
            ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('44', style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.bold
                        ),),
                         Text('Posts', style: AppTextStyles.title,)

                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: Get.height * 0.08,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('123', style: AppTextStyles.title.copyWith(
                          fontWeight: FontWeight.bold
                        ),),
                        Text('Followers', style: AppTextStyles.title,)

                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('144', style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.bold
                        ),),
                        Text('Following', style: AppTextStyles.title,)

                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: Get.height * 0.08,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('123', style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.bold
                        ),),
                        Text('Followers', style: AppTextStyles.title,)

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
                      itemCount: 5,
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
                                backgroundImage: AssetImage('assets/images/friend1.png'), // Replace this with your image
                              ),
                              SizedBox(height: 10,),
                              Text('John' , style: AppTextStyles.headlineMedium,),

                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.04,),





        ],
      ),
    );
  }
}
