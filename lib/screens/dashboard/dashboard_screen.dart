

import 'package:flutter/material.dart';
 import 'package:skincare/core/utils/colors.dart';


import '../../core/utils/styles.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);
  // @override
  // void initState() {
  //   pageController = PageController(
  //     initialPage: currentIndex,
  //   );
  //   super.initState();
  // }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              currentIndex = page;
            });
          },
          children:   [
            HomeScreen(),
            HomeScreen(),
            HomeScreen(),
              ProfileScreen(),

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            pageController.jumpToPage(index);
            setState(() {});
          },
          backgroundColor: Color(0xffFEA500),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.greyD0,
          selectedLabelStyle:
          AppTextStyles.bodySmall.copyWith(color: AppColors.primaryColor),
          unselectedLabelStyle: AppTextStyles.bodySmall,
          items: [
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/home.png'),
                size: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/shop.png'),
                size: 24,
              ),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/search.png'),
                size: 24,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/profile.png'),
                size: 24,
              ),
              label: 'Profile',
            ),
          ],
        ));
  }
}
