import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/route/route.dart';
import '../../../viewModel/News Controller.dart';

final NewsController controller = Get.find();

Widget carouselSliderWidgets() {
  return Obx(
    () => controller.isLoading.value
        ? const CupertinoActivityIndicator(
            color: BaseColors.newsbackbtnColor,
            radius: 12,
          )
        : controller.topHeadlines.value.data != null ||
                (controller.topHeadlines.value.data ?? []).isNotEmpty
            ? CarouselSlider(
                options: CarouselOptions(
                    height: 220.0.h,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    animateToClosest: true),
                items: controller.topHeadlines.value.data?.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(BaseRoute.newsDetailsScreen,arguments: item),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Stack(
                            children: [
                              Positioned(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(BaseAssets.topNews),
                                    height: 200.h,
                                    item.photoUrl ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: (200 - 60) / 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      item.title ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 10,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 40),
                                  child: SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      item.snippet ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            : const Center(child: Text('No data available')),
  );
}
