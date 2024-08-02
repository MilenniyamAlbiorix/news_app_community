import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:news_app_community/controller/News%20Controller.dart';

import 'package:news_app_community/res/const/assets.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../controller/News Controller.dart';
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
    return Scaffold(
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
            //setState function
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
                          const TextSpan(
                            text:
                                ' — Cryptocurrencies “have no intrinsic value” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey said. Digital currencies like bitcoin, ether and even dogecoin have been on a tear this year, reminding some investors of the 2017 crypto bubble in which bitcoin blasted toward \$20,000, only to sink as low as \$3,122 a year later. Asked at a press conference Thursday about the rising value of cryptocurrencies, Bailey said: “They have no intrinsic value. That doesn’t mean to say people don’t put value on them, because they can have extrinsic value. But they have no intrinsic value.” “I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.” Bailey’s comments echoed a similar warning from the U.K.’s Financial Conduct Authority. “Investing in cryptoassets, or investments and lending linked to them, generally involves taking very high risks with investors’ money,” the financial services watchdog said in January. “If consumers invest in these types of product, they should be prepared to lose all their money.” Bailey, who was formerly the chief executive of the FCA, has long been a skeptic of crypto. In 2017, he warned: “If you want to invest in bitcoin, be prepared to lose all your money.”',
                          ),
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
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize + 50,
            child: Container(
              color: Colors.black26,
              child: Stack(alignment: Alignment.topCenter, children: [
                Opacity(
                  opacity: percent,
                  child: Center(
                    child: Image.asset(
                      width: Get.width,
                      BaseAssets.topNews,
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
            left: 16.0,
            right: 16.0,
            top: max(180, appBarSize - 20),
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 311.w,
                  height:min(appBarSize, 200),
                  decoration: BoxDecoration(
                    color: BaseColors.bluerColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sunday, 9 May 2021",
                          style: getTheme(context: context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: BaseColors.backBtnColor,
                                  fontSize: 12),
                        ),
                        Text(
                          "Crypto investors should be prepared to lose all their money, BOE governor says",
                          style: getTheme(context: context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: BaseColors.backBtnColor,
                                  fontSize: 16.sp),
                        ),
                        Text(
                          "Published by Ryan Browne",
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
                  ),
                ),
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
