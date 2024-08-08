import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import 'package:news_app_community/res/const/assets.dart';
import '../../../res/const/Colors.dart';
import '../../../res/functions/base_funcations.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final NewsController newsController = Get.find();
  final ScrollController _scrollController = ScrollController();
  bool isScrollingUp = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isScrollingUp) {
        setState(() {
          isScrollingUp = false;
        });
      }
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isScrollingUp) {
        setState(() {
          isScrollingUp = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newsController.topHeadLineDetails = Get.arguments;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        height: 56.h,
        width: 56.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [BaseColors.gradintOne, BaseColors.gradintTwo],
          ),
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape:
              const CircleBorder(side: BorderSide(color: Colors.transparent)),
          onPressed: () {
            List<Datum> updatedItems = List.from(newsController.items.value);
            updatedItems.add(Get.arguments);
            newsController.items.value = updatedItems;
            newsController.addItem(updatedItems);
            //   newsController.items.value = [Get.arguments];
            // newsController.addItem( newsController.items.value);
          },
          child: Image.asset(
            BaseAssets.group,
            height: 18.5.h,
            width: 22.5.w,
          ),
        ),
      ).paddingSymmetric(horizontal: 10, vertical: 20),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            newsController.isPadding.value = true;
            if (scrollNotification.metrics.pixels > 200) {
              newsController.atEdge.value = true;
            }
            if (scrollNotification.metrics.pixels > 210) {
              newsController.startAnimation.value = true;
            }
          } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            newsController.isPadding.value = false;
            if (scrollNotification.metrics.pixels < 250) {
              newsController.atEdge.value = false;
            }
          }
          return true;
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: Get.height < 900
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: CustomSliverDelegate(
                expandedHeight: 200,
              ),
            ),
            SliverFillRemaining(
              child: Obx(
                () => ListView(
                  padding: !newsController.isPadding.value
                      ? const EdgeInsets.all(0)
                      : EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RichText(
                      text: TextSpan(
                        style: getTheme(context: context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: BaseColors.backBtnColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: 'LONDON',
                            style: getTheme(context: context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: BaseColors.backBtnColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text:
                                  "- ${newsController.topHeadLineDetails.title} " ??
                                      ""),
                        ],
                      ),
                      textAlign: TextAlign.justify,
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
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  final NewsController newsController = Get.find();

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    final date = DateTime.parse(
        newsController.topHeadLineDetails.publishedDatetimeUtc.toString());
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(date);
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height:
                appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize + 50,
            child: Container(
              color: Colors.black26,
              child: Stack(alignment: Alignment.topCenter, children: [
                Opacity(
                  opacity: percent,
                  child: Center(
                    child: Image.network(
                      height: Get.height,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(BaseAssets.topNews),
                      width: Get.width,
                      newsController.topHeadLineDetails.photoUrl ?? "",
                    ),
                  ),
                ),
                Positioned(
                  top: 00,
                  left: 20,
                  child: SafeArea(
                    top: true,
                    child: InkWell(
                        onTap: () {
                          newsController.atEdge.value = false;
                          Navigator.pop(Get.context!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 32.w,
                              width: 32.w,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                border: Border.all(
                                  width: 0,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: BaseColors.newsbackbtnColor,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            top: 180,
            bottom: 0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 311.w,
                        decoration: BoxDecoration(
                          color: BaseColors.bluerColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 0,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 8, right: 16, bottom: 0),
                          child: Wrap(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedDate.toString(),
                                    // args.name?? "",
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: BaseColors.backBtnColor,
                                            fontSize: 12.sp),
                                  ),
                                  Text(
                                    newsController.topHeadLineDetails.title
                                        .toString(),
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: BaseColors.backBtnColor,
                                            fontSize: 16.sp),
                                  ),
                                  Text(
                                    "Published by ${newsController.topHeadLineDetails.sourceName}" ??
                                        "",
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: BaseColors.backBtnColor,
                                          fontSize: 10,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
