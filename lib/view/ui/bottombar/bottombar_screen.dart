import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_community/controller/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final NewsController newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () =>
                newsController.screens[newsController.selectedIndex.value ?? 0],
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    32,
                  ),
                  color: BaseColors.whiteColor),
              width: 100.w,
              child: BottomNavigationBar(
                elevation: 4,
                backgroundColor: BaseColors.whiteColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      BaseAssets.homeActive,
                      height: 24.h,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      BaseAssets.favoriteUnSelcted,
                      height: 24.h,
                    ),
                    label: 'Favorite',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: newsController.selectedIndex.value ?? 0,
                onTap: (index) {
                  newsController.selectBottomNavItem(index);
                },
              ),
            ).paddingSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}
