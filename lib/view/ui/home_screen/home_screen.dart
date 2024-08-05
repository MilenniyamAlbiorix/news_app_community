import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/res/functions/base_funcations.dart';
import 'package:news_app_community/route/route.dart';
import 'package:news_app_community/utils/extensions/base_extensions.dart';
import 'carouselSlider_widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>  Scaffold(
        backgroundColor: BaseColors.whiteColor,
        appBar: AppBar(
          backgroundColor: BaseColors.whiteColor,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 32.h,
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: BaseStrings.search,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {

                  },
                ),
                hintStyle: getTheme(context: context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(
                    fontSize: 12.sp,
                    color: BaseColors.colorBorder.withOpacity(0.8)),
                contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              controller: newsController.searchController,
            ),
          ),
          actions: [
            GestureDetector(
              child: Image.asset(BaseAssets.notifiationIcon)
                  .paddingSymmetric(horizontal: 15),
              onTap: (){
Get.toNamed(BaseRoute.notificationScreen);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Latest News",
                    style: getTheme(context: context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                        color: BaseColors.blackColors,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: ()=>Get.toNamed(BaseRoute.searchScreen),
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: getTheme(context: context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: BaseColors.iconColor),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: BaseColors.iconColor,
                        size: 12,
                      )
                    ],
                  ),
                ),
              ],
            ),
            10.toVSB,
            Obx(()=>  newsController.topHeadlines.value.data == null || newsController.topHeadlines.value.data!.isEmpty  ? carouselSliderWidgets() : Center(child: Text('No data available')),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: SizedBox(
                height: 32.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newsController.categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          newsController.selectChip(index);
                        },
                        child: Obx(
                              () => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: BaseColors.searchBarHintTextColor),
                              gradient: LinearGradient(
                                colors:
                                newsController.selectedCategory.value == index
                                    ? [
                                  BaseColors.gradintOne,
                                  BaseColors.gradintTwo,
                                ]
                                    : [
                                  BaseColors.whiteColor,
                                  BaseColors.whiteColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius:
                              BorderRadius.circular(20.0), // Rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Center(
                              child: Text(
                                newsController.categories[index],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                  newsController.selectedCategory.value == index
                                      ? BaseColors.whiteColor
                                      : BaseColors.backBtnColor, // Text color
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 345,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage(BaseAssets.frame),
                        // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10,
                            left: 10,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    '5 things to know about the "conundrum" of lupus',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            'Matt Villano',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text(
                            'Sunday, 9 May 2021',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).paddingSymmetric(vertical: 8.0);
                },
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 15),

      ),
    );
  }

  final newsController = Get.find<NewsController>();
}
