import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_community/controller/News%20Controller.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/res/functions/base_funcations.dart';
import 'package:news_app_community/utils/extensions/base_extensions.dart';
import 'package:news_app_community/view/ui/search_Screen/search_helper.dart';

import '../../../res/const/Colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final NewsController newsController = Get.find();

  final SearchHelper searchHelper = SearchHelper();

  final List<String> chipLabels = [
    'Recommended',
    'Latest',
    'Most Viewed',
    'Channel',
    'Following',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: BaseColors.whiteColor,
        automaticallyImplyLeading: false,
        title: SizedBox(
            height: 32.h,
            child: searchHelper.searchListWidgets(
                context: context, controller: newsController.searchController)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchHelper.filterNews(
              context: context,
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: BaseColors.whiteColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12))),
                      height: 300,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(BaseStrings.filter,
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: BaseColors.filterTxtColor)),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    backgroundColor: WidgetStateProperty.all(
                                        BaseColors.whiteColor),
                                    side: WidgetStateProperty.all(
                                        const BorderSide(color: Colors.black)),
                                    fixedSize: WidgetStateProperty.all(
                                        Size(100.w, 32.w)),
                                  ),
                                  onPressed: () {
                                    newsController.selectedChips.clear();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.delete,
                                        color: BaseColors.filterTxtColor,
                                        size: 12.sp,
                                      ),
                                      8.toHSB,
                                      Text(BaseStrings.reset,
                                          style: getTheme(context: context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontSize: 12.sp,
                                                  color: BaseColors
                                                      .filterTxtColor)),
                                    ],
                                  ).paddingZero,
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 12),
                            Text(BaseStrings.sortBy,
                                style: getTheme(context: context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: BaseColors.filterTxtColor)),
                            Obx(() {
                              return Wrap(
                                spacing: 10.0,
                                children: chipLabels.map((label) {
                                  return ChoiceChip(
                                    side: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    showCheckmark: true,

                                    label: Text(label),
                                    selected: newsController.selectedChips
                                        .contains(label),
                                    onSelected: (bool selected) {
                                      newsController.selectMultiChip(label);
                                    },
                                  ).paddingSymmetric(horizontal: 4);
                                }).toList(),
                              );
                            }),
                            Container(
                              width: Get.width,
                              height: 48.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  colors: [
                                    BaseColors.gradintOne,
                                    BaseColors.gradintTwo
                                  ], // Define your gradient colors
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                    color: Colors.transparent,
                                    width: 1.0), // Add the black border
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(BaseStrings.save,
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: 16.sp,
                                            color: BaseColors.whiteColor,
                                            fontWeight: FontWeight.w800)),
                              ),
                            ).paddingSymmetric(horizontal: 15),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return searchHelper
                    .filterListingView()
                    .paddingSymmetric(horizontal: 15);
              },
            ),
          )
        ],
      ),
    );
  }
}
