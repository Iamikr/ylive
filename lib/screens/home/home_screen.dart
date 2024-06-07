import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:skincare/core/utils/assets_constant.dart';
import 'package:skincare/screens/profile/profile_screen.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/styles.dart';
import '../../models/api_response.dart';
import '../../services/authentication_service.dart';
import '../auth/login/login_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  final HomeController controller = Get.put(HomeController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor.withOpacity(0.8),
              AppColors.primaryColor.withOpacity(0.8)
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: buildDrawer(user),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: AppTextStyles.bodyLarge,
                    ),
                    Text(
                      'Check out whats new',
                      style: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor.withOpacity(0.5)),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                scrollDirection: Axis.horizontal,
              ),
              items: [
                const AssetImage(AppAssets.vac1),
                const AssetImage(AppAssets.vac2),
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Image(
                        image: item,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            // add child
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(

              height: Get.height * 0.06,
              width: Get.width * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backgroundColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppAssets.child),
              ),
            ),
              SizedBox(height: Get.height * 0.01,),
               Center(
              child: Text('Add Child', style: AppTextStyles.primaryColorText.copyWith(
                fontSize: 12
              ),),
            ),


            // available vaccine

            SizedBox(
              height: Get.height * 0.06,
            ),
            Container(

              height: Get.height * 0.06,
              width: Get.width * 0.06,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppAssets.injection),
              ),
            ),
            SizedBox(height: Get.height * 0.01,),
            Center(
              child: Text('No upcoming vaccine available', style: AppTextStyles.primaryColorText.copyWith(
                  fontSize: 12
              ),),
            ),

           // doctor
            SizedBox(
              height: Get.height * 0.06,
            ),
            Container(

              height: Get.height * 0.06,
              width: Get.width * 0.06,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppAssets.doctor),
              ),
            ),
            SizedBox(height: Get.height * 0.01,),
            Center(
              child: Text('No doctor found in your location', style: AppTextStyles.primaryColorText.copyWith(
                  fontSize: 12
              ),),
            )

          ],
        ),
      ),
    );
  }

  SafeArea buildDrawer(User? user) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                      width: 64.0,
                      height: 64.0,
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user?.photoURL ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      children: [
                        Text(
                          user?.displayName ?? 'No Name',
                          style: AppTextStyles.drawerTitle,
                        ),
                        Text(
                          user?.email ?? '',
                          style: AppTextStyles.drawerTitle
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset('assets/images/home.png',
                    height: 24, width: 24),
                title: Text(
                  'Home',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset('assets/images/injection2.png',
                    height: 24, width: 24, color: Colors.white,),
                title: const Text(
                  'Schedule Vaccine',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.calendar_today_outlined,size: 20,),
                title: Text(
                  'My Appointment',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset(AppAssets.completed,
                    height: 24, width: 24, color: Colors.white,),
                title: const Text(
                  'Completed Vaccine',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.shopping_cart,size: 20,),
                title: Text(
                  'My Orders',
                  style: AppTextStyles.drawerTitle,
                ),
              ),

              ListTile(
                onTap: () {},
                leading: Image.asset('assets/images/notification.png',
                    height: 24, width: 24),
                title: Text(
                  'Notification',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.content_paste_sharp,size: 20,),
                title: Text(
                  'Reward and referal',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.language,size: 20,),
                title: Text(
                  'Select Language',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.lock,size: 20,),
                title: Text(
                  'Change Password',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.info_outline,size: 20,),
                title: Text(
                  'About Us',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.privacy_tip_outlined,size: 20,),
                title: Text(
                  'Privacy Policy',
                  style: AppTextStyles.drawerTitle,
                ),
              ),

              ListTile(
                onTap: () {},
                leading: Image.asset('assets/images/messages.png',
                    height: 24, width: 24),
                title: Text(
                  'Messages',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset('assets/images/people.png',
                    height: 24, width: 24),
                title: Text(
                  'Friends',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
              Spacer(),
              ListTile(
                onTap: () {
                  _signOut();
                },
                leading: Image.asset(
                  'assets/images/logout.png',
                  height: 24,
                  width: 24,
                  color: AppColors.whiteColor,
                ),
                title: Text(
                  'LogOut',
                  style: AppTextStyles.drawerTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: AppColors.primaryColor,
        fontSize: 16.0);
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

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
