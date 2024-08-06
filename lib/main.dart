import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news_app_community/Data/service/News_services.dart';
import 'package:news_app_community/repositories/search_news/search_news_impl.dart';
import 'package:news_app_community/repositories/search_news/search_news_repo.dart';
import 'package:news_app_community/repositories/top_headline/top_headline_repo.dart';
import 'package:news_app_community/repositories/top_headline/top_headlines_repo_impl.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/route/pages.dart';
import 'package:news_app_community/route/route.dart';
import 'package:news_app_community/view/ui/notication/notifaction_screen.dart';

void main() {
  final NewsServices newsServices = NewsServices(BaseStrings.baseUrl);
  final TopHeadlineRepo officeRepository = TopHeadlineRepoImpl(newsServices);
  final SearchNewsRepo searchNewsRepo = SearchNewsImpl(newsServices);
  Get.put(NewsController(topHeadlineRepo: officeRepository,searchNewsRepo: searchNewsRepo));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: BaseColors.whiteColor,
      getPages: AppPages.pages,
      initialRoute: BaseRoute.bottomBarScreen,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
          builder: (context, child) => const NotificationScreen()),
    );
  }
}
