import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_community/res/functions/base_funcations.dart';
import '../../../res/const/strings.dart';
import '../../../utils/widgets/gradientText.dart';
import 'notificaton_listing_widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
          title: GradientText(
            BaseStrings.hotUpdates,
            style: getTheme(context: context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFF3A44),
                Color(0xffFF8086),
              ],
            ),
          ),),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return notificationListing(context: context);
              },
            ),
          )
        ],
      ),
    );
  }

}
