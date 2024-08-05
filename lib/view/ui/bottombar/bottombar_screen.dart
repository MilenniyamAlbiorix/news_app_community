import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/const/strings.dart';

class BottomBarScreen extends StatelessWidget {
   BottomBarScreen({super.key});

  final NewsController newsController = Get.find<NewsController>();

  final PageController _pageController = PageController( initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PopScope(
            canPop: false,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                print("----------------------index : $index");
                newsController.selectedIndex.value = index;
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
                    selectedFontSize: 10.sp,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          newsController.selectedIndex.value == 0 ?   BaseAssets.homeActive : BaseAssets.homeUnSelected,
                          height: 24.h,
                        ),
                        label: BaseStrings.home,
                      ),
                      BottomNavigationBarItem(
                        icon:Image(
                          image: AssetImage(newsController.selectedIndex.value == 1 ? BaseAssets.favoriteActive: BaseAssets.favoriteUnSelcted,),
                          height: 20.h,
                        ),
                        label:BaseStrings.favorite,
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: BaseStrings.profile,
                      ),
                    ],
                    currentIndex: newsController.selectedIndex.value,
                    onTap: (index) {
                      newsController.selectedIndex.value = index;
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ).paddingSymmetric(horizontal: 20),
            ),
        ],
      ),
    );
  }
}
