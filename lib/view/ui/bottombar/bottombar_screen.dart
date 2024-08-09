import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/const/strings.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

  final PageController pageController = PageController( initialPage: 0);
  @override
  void initState() {
    newsController.selectedIndexes.value = 0;
    super.initState();
  }
  final NewsController newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PopScope(
            canPop: false,
            child: PageView(

              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                print("----------------------index : $index");
                newsController.selectedIndexes.value = index;
              },
              children: newsController.screens,
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: BaseColors.whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(
                    ()=> BottomNavigationBar(
                      selectedLabelStyle: const TextStyle(color: BaseColors.bluerColor),
                  selectedFontSize: 10.sp,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  items: [
                    BottomNavigationBarItem(
                      icon: Obx(
                            ()=> Image.asset(
                          newsController.selectedIndexes.value == 0 ?   BaseAssets.homeActive : BaseAssets.homeUnSelected,
                          height: 24.h,
                        ),
                      ),
                      label: BaseStrings.home,
                    ),
                    BottomNavigationBarItem(
                      icon: Obx(
                            ()=> Image.asset(
                          newsController.selectedIndexes.value == 1 ?   BaseAssets.favoriteActive : BaseAssets.favoriteUnSelcted,
                          height: 24.h,
                        ),
                      ),
                      label:BaseStrings.favorite,
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: BaseStrings.profile,
                    ),
                  ],
                  currentIndex: newsController.selectedIndexes.value ,
                  onTap: (index) {
                  newsController.selectedIndexes.value = index;
                  pageController.jumpToPage(index );
                  },
                ),
              ),
            ).paddingSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
