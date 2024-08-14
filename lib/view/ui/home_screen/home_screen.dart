import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:news_app_community/view/ui/home_screen/topic_news_card_widget.dart';
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
  FocusNode searchFoCus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => Scaffold(
          backgroundColor: BaseColors.whiteColor,
          appBar: AppBar(
            backgroundColor: BaseColors.whiteColor,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 32.h,
              child: Obx(
                () => TextFormField(
                  focusNode: searchFoCus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    setState(() {
                      searchFoCus.unfocus();
                      newsController.searchNewsList(
                          newsController.searchController.value.text, context);
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: BaseStrings.search,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        searchFoCus.unfocus();
                        newsController.searchNewsList(
                            newsController.searchController.value.text,
                            context);
                      },
                    ),
                    hintStyle: getTheme(context: context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            fontSize: 12.sp,
                            color: BaseColors.blackColors.withOpacity(0.8)),
                    contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  controller: newsController.searchController.value,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                child: Image.asset(BaseAssets.notifiationIcon)
                    .paddingSymmetric(horizontal: 15),
                onTap: () {
                  // Get.toNamed(BaseRoute.notificationScreen);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Obx(
              () => newsController.searchController.value.text.isNotEmpty
                  ? newsController.isSearchLoading.value
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            color: BaseColors.newsbackbtnColor,
                            radius: 12,
                          ),
                        )
                      : newsController.results.isNotEmpty ?
              SizedBox(
                height: 880.h,
                child: ListView.builder(
                            itemCount: newsController.results.length,
                            itemBuilder: (context, index) {
                              final article = newsController.results[index];
                              final date = DateTime.parse(newsController
                                  .results[index].publishedAt
                                  .toString());
                              String formattedDate =
                                  DateFormat('EEEE, d MMMM yyyy').format(date);
                              return
                                   newsCardWidgets(
                                      imageUrl: article.urlToImage ??"",
                                      author: article.author?? "",
                                      date: formattedDate.toString() ?? "",
                                      title: article.title ?? "",
                                    ).paddingSymmetric(horizontal: 15);
                
                            },
                          ),
              )  : const Center(
heightFactor: 30,
                child: Text(BaseStrings.noDataFound),
              )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    BaseRoute.newsDetailsScreen,
                                  );
                                },
                                child: Text(
                                  BaseStrings.latestNews,
                                  style: getTheme(context: context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: BaseColors.blackColors,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                ).paddingOnly(left: 8),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // await newsController.fetchTopHeadline();
                                Get.toNamed(
                                  BaseRoute.searchScreen,
                                );
                              },
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
                        SizedBox(height: 220.0.h,child: carouselSliderWidgets(),),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: SizedBox(
                            height: 32.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: newsController.categories.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      newsController.selectChip(index);
                                    },
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: BaseColors
                                                  .searchBarHintTextColor),
                                          gradient: LinearGradient(
                                            colors: newsController
                                                        .selectedCategory.value ==
                                                    index
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
                                          borderRadius: BorderRadius.circular(
                                              20.0), // Rounded corners
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Center(
                                          child: Text(
                                            newsController.categories[index],
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: newsController
                                                          .selectedCategory
                                                          .value ==
                                                      index
                                                  ? BaseColors.whiteColor
                                                  : BaseColors
                                                      .backBtnColor, // Text color
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
                        Obx(
                          () => newsController.isTopicLoading.value
                              ? const Center(
                                  heightFactor: 3.5,
                                  child: SpinKitCircle(
                                    color: Colors.black,
                                    size: 50.0,
                                  ),
                                ).paddingSymmetric(vertical: 60)
                              : newsController.topicHeadline.isNotEmpty
                                  ? SizedBox(
                            height: 800.h,
                                    child: ListView.builder(
                                      itemCount:
                                          newsController.topicHeadline.length,
                                      itemBuilder: (context, index) {
                                        String formattedDate =
                                        DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(newsController
                                            .topicHeadline[index].publishedAt.toString()));
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                BaseRoute.newsDetailsScreen,
                                                arguments: newsController
                                                    .topicHeadline[index]);
                                          },
                                          child: Container(
                                            width: 345,
                                            height: 128,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                onError:
                                                    (exception, stackTrace) =>
                                                        Image.asset(
                                                            BaseAssets.topNews),
                                                image: NetworkImage(
                                                    newsController
                                                            .topicHeadline[
                                                                index]
                                                            .urlToImage ??
                                                        ""),
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
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          width: 300.w,
                                                          child: Text(
                                                            maxLines: 3,
                                                            newsController
                                                                    .topicHeadline[
                                                                        index]
                                                                    .title ??
                                                                "",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),),
                                                 Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: Text(
                                                    newsController
                                                        .topicHeadline[
                                                    index]
                                                        .author ??
                                                        "",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                 Positioned(
                                                  bottom: 10,
                                                  right: 10,
                                                  child: Text(
                                                    formattedDate ,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingSymmetric(vertical: 8.0),
                                        );
                                      },
                                    ),
                                  )
                                  : const Center(
                            heightFactor:16,
                                      child: Text(BaseStrings.noDataFound),
                                    ),
                        ),
                      ],
                    ).paddingSymmetric(
                      horizontal: 15,
                    ),
            ),
          )),
    );
  }

  final newsController = Get.find<NewsController>();
}
