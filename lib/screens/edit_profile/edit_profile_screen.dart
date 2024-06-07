


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/core/utils/styles.dart';

import '../../core/utils/colors.dart';
import 'edit_profile_from.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Edit Profile', style: AppTextStyles.appBarText,),
      ),
      body: ListView(
        padding: EdgeInsets.only(
            top: 20,
          right: 20,
          left: 20,
        ),

        children: [



          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
              NetworkImage( 'https://cdn-icons-png.freepik.com/256/3135/3135715.png?semt=ais_hybrid'),
            ),
          ),
          SizedBox(height: Get.height * 0.04,),
          EditProfileForm(),












        ],
      ),
    );
  }
}
