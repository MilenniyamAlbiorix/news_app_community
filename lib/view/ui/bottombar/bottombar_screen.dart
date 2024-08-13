import 'package:flutter/foundation.dart';
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



  void onTabTapped(int index) {
setState(() {
  newsController.selectedIndexes.value = index;
  pageController.jumpToPage(index);
});

  }
  @override
  void initState() {
    super.initState();
  }

  final NewsController newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child:  Scaffold(
        body: Stack(
          children: [
            PopScope(
              canPop: false,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  if (kDebugMode) {
                    print("----------------------index : $index");
                  }
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
                  currentIndex: newsController.selectedIndexes.value ?? 0,
                  onTap:onTabTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        BaseAssets.homeActivePng,
                        color:  newsController.selectedIndexes.value == 0
                            ? BaseColors.gradintOne
                            : Colors.grey.shade600,
                        width: 24,
                        height: 24,
                      ),
                      label: BaseStrings.home,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        BaseAssets.favoriteActivePng,
                        color:  newsController.selectedIndexes.value == 1
                            ? BaseColors.gradintOne
                            : Colors.grey.shade600,
                        width: 24,
                        height: 24,
                      ),
                      label: BaseStrings.favorite,
                    ),
                    BottomNavigationBarItem(
                      icon:   Icon(Icons.person,color: newsController.selectedIndexes.value == 2
                          ? BaseColors.gradintOne
                          : Colors.grey.shade600,
                      )
                     , label: BaseStrings.profile,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
