import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/const/strings.dart';

import '../../../utils/widgets/custom_bottom_bar.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
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
            bottom: 40,
            left: 20,
            right: 20,
            child: Obx(
                  () => CustomBottomNavigationBar(
                currentIndex: newsController.selectedIndexes.value,
                onTap: (index) {
                  newsController.selectedIndexes.value = index;
                  pageController.jumpToPage(index);
                },
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: BaseColors.searchBarHintTextColor,
                  activeIcon:  SvgPicture.asset(
                  BaseAssets.homeActive,
                    height: 24.h,
                  ),
                    icon:
                    SvgPicture.asset(
                      BaseAssets.homeUnSelected,
                      height: 24.h,
                    ),
                    label: BaseStrings.home,
                  ),
                  BottomNavigationBarItem(
                    icon: newsController.selectedIndexes.value == 1
                        ? SvgPicture.asset(
                      BaseAssets.favoriteActive,
                      height: 22.h,
                    )
                        : SvgPicture.asset(
                      BaseAssets.favoriteUnSelcted,
                      height: 22.h,
                    ),
                    label: BaseStrings.favorite,
                  ),
                  BottomNavigationBarItem(
                    icon:  newsController.selectedIndexes.value == 2  ?  const Icon(Icons.person) :  const Icon(Icons.person_2_outlined),
                    label: BaseStrings.profile,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("pageControllr dispose");
    pageController.dispose();
    super.dispose();
  }
}
