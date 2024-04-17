

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';


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
            colors: [AppColors.primaryColor.withOpacity(0.8), AppColors.primaryColor.withOpacity(0.8)],
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
      child: Scaffold(

        body: ListView(
          shrinkWrap: true,

          padding: const EdgeInsets.only(
              top: 50,
              left: 10,
              right: 10
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome Back' , style: AppTextStyles.bodyLarge,),
                    Text('Check out whats new on MyYearLive'   , style: AppTextStyles.bodyLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor.withOpacity(0.5)
                    ),),
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
            SizedBox(            height: Get.height * 0.03,
            ),

            Stack(
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: Get.width,
                  padding: EdgeInsets.only(
                      left: 10 ,
                      top: 24
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20)
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Explore new items added to\nthe Marketplace for your \n school life needs.',
                          style: AppTextStyles.primaryColorText.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w300
                          )
                      )

                    ],
                  ),
                ),
                Positioned(
                    right:  0,
                    bottom: 0,

                    child: Image.asset('assets/images/schoolBox.png',
                      height: Get.height * 0.14,))
              ],
            ),
            SizedBox(   height: Get.height * 0.03,
            ),
            const Text('New Yearbooks' , style: AppTextStyles.bodySmall,),
            SizedBox(   height: Get.height * 0.02),

            SizedBox(
              height: Get.height * 0.3,

              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.yearBookImages.length,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index){
                    return   Padding(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10

                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              controller.yearBookImages[index],
                              fit: BoxFit.cover,
                              height : Get.height * 0.25,
                              width: Get.width * 0.5,
                            ),
                          ),

                          SizedBox(height: 10,),
                          Text(controller.bookTitle[index] , style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),),

                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(   height: Get.height * 0.02),

            const Text('Trending Videos' , style: AppTextStyles.bodySmall,),

            SizedBox(   height: Get.height * 0.02),

            SizedBox(
              height: Get.height * 0.3,

              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:  controller.trendingImages.length,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index){
                    return   Padding(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          controller.trendingImages[index],
                          fit: BoxFit.cover,
                          height : Get.height * 0.25,
                          width: Get.width * 0.5,
                        ),
                      ),
                    );
                  }),
            ),

            SizedBox(   height: Get.height * 0.1),


          ],
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10
                  ),
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
                      SizedBox(width: 12,),
                      Column(
                        children: [
                          Text(user?.displayName ?? '', style: AppTextStyles.drawerTitle,),
                          Text(user?.email ?? '',
                            style: AppTextStyles.drawerTitle.copyWith(fontSize: 12),),
                        ],
                      )

                    ],
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/images/profile.png', height: 24 , width: 24),
                  title: Text('Profile', style: AppTextStyles.drawerTitle,),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/images/shop.png', height: 24 , width: 24),
                  title: Text('Shop', style: AppTextStyles.drawerTitle,),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/images/myBook.png', height: 24 , width: 24),
                  title: Text('My Yearbooks', style: AppTextStyles.drawerTitle,),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/images/notification.png', height: 24 , width: 24),
                  title: Text('Notification', style: AppTextStyles.drawerTitle,),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/images/messages.png', height: 24 , width: 24),
                  title: Text('Messages', style: AppTextStyles.drawerTitle,),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset('assets/images/people.png', height: 24 , width: 24),
                  title: Text('Friends', style: AppTextStyles.drawerTitle,),
                ),
                Spacer(),
                ListTile(
                  onTap: () {
                    _signOut();
                  },
                  leading: Image.asset('assets/images/logout.png', height: 24 , width: 24, color: AppColors.whiteColor,),
                  title: Text('LogOut', style: AppTextStyles.drawerTitle,),
                ),

              ],
            ),
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


