import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/res/const/strings.dart';
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

  bool showGlassmorphism = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && showGlassmorphism) {
        setState(() {
          showGlassmorphism = false;
        });
      } else if (_scrollController.offset <= 0 && !showGlassmorphism) {
        setState(() {
          showGlassmorphism = true;
        });
      }
    });
  }

  /* void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }*/

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
            final arguments = Get.arguments;
            final List<Article> list;
            if (arguments is List<Article>) {
              list = arguments;
            } else if (arguments is Article) {
              list = [arguments];
            } else {
              return; // Or handle the error as needed
            }
            newsController.addItem(list);
            const GetSnackBar(
              message: BaseStrings.newSave,
              title: BaseStrings.save,
              snackPosition: SnackPosition.BOTTOM,
            );
            newsController.loadItemsFromStorage();
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
              floating: true,
              pinned: true,
              delegate: CustomAppBar(),
            ),
            SliverFillRemaining(
                fillOverscroll: true,
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          const TextSpan(
                            text: '-  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: newsController.topHeadLineDetails.description,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ).paddingSymmetric(horizontal: 14),
                  ],
                )),
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
        newsController.topHeadLineDetails.publishedAt.toString());
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
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Opacity(
                    opacity: percent,
                    child: Center(
                      child: Image.network(
                        height: Get.height,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(BaseAssets.topNews),
                        width: Get.width,
                        newsController.topHeadLineDetails.urlToImage ?? "",
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                                    "",
                                    // formattedDate.toString(),
                                    // args.name?? "",
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: BaseColors.backBtnColor,
                                            fontSize: 12.sp),
                                  ),
                                  Text(
                                    "",
                                    // newsController.topHeadLineDetails.title
                                    //     .toString(),
                                    style: getTheme(context: context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: BaseColors.backBtnColor,
                                            fontSize: 16.sp),
                                  ),
                                  Text(
                                    "",
                                    // "Published by ${newsController.topHeadLineDetails.sourceName}" ??
                                    //     "",
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

class CustomAppBar extends SliverPersistentHeaderDelegate {
  final bottomHeight = 60;
  final extraRadius = 5;

  final NewsController newsController = Get.find();

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final date = DateTime.parse(
        newsController.topHeadLineDetails.publishedAt.toString());
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(date);
    final imageTop =
        -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);

    final double opacity = shrinkOffset == minExtent
        ? 0
        : 1 - (shrinkOffset.clamp(minExtent, minExtent + 30) - minExtent) / 30;
    final double tiltOpacity = shrinkOffset == maxExtent
        ? 1 - (shrinkOffset.clamp(maxExtent, maxExtent + 30) - maxExtent) / 30
        : 0;
    return Stack(
      children: [
        // Positioned(
        //   bottom: 0,
        //   right: 20,
        //   left: 45,
        //   child: Row(
        //     children: [
        //       Transform.scale(
        //         scale: 1.9 - clowsingRate,
        //         alignment: Alignment.bottomCenter,
        //         child: const _Avatar(),
        //       ),
        //
        //       // const _Button(),
        //     ],
        //   ),
        // ),
        Stack(
          children: [
            Positioned(
              top: imageTop,
              left: 0,
              right: 0,
              child: ClipPath(
                child: SizedBox(
                  height: maxExtent - bottomHeight,
                  child: ColoredBox(
                    color: Colors.grey,
                    child: Opacity(
                      opacity: opacity,
                      child: Image.network(
                        newsController.topHeadLineDetails.urlToImage ?? "",
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(BaseAssets.group),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              // Adjust position as needed
              left: 0,
              right: 0,
              bottom: 0,
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
                                  "Published by ${newsController.topHeadLineDetails.author}" ??
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
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 5,
          left: 10,
          right: 10,
          child: Row(
            children: [
              _IconButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.arrow_back,
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 13,
          left: 20,
          right: 10,

          child: Center(
              child: Opacity(
                  opacity: tiltOpacity,
                  child: SizedBox(
                    width: 250.w,
                      child: Text(newsController.topHeadLineDetails.title ?? "",overflow: TextOverflow.ellipsis,maxLines: 1,)))),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});

  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap!,
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
      ),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  const InvertedCircleClipper({
    required this.offset,
    required this.radius,
  });

  final Offset offset;
  final double radius;

  @override
  Path getClip(size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: offset,
        radius: radius,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
