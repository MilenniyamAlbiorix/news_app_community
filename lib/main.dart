import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news_app_community/controller/News%20Controller.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/route/pages.dart';
import 'package:news_app_community/route/route.dart';
import 'package:news_app_community/view/ui/notication/notifaction_screen.dart';

void main() {

  Get.put(NewsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: BaseColors.canvasColor,
      getPages: AppPages.pages,
      initialRoute: BaseRoute.homeScreen,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  ScreenUtilInit(builder: (context, child) => const  NotificationScreen()),
    );
  }
}
