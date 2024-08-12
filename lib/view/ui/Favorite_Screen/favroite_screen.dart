import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/viewModel/News%20Controller.dart';
import '../../../res/const/strings.dart';
import '../../../res/functions/base_funcations.dart';
import '../../../utils/widgets/gradientText.dart';
import '../notication/notificaton_listing_widgets.dart';

class FavroiteScreen extends StatefulWidget {
  const FavroiteScreen({super.key});

  @override
  State<FavroiteScreen> createState() => _FavroiteScreenState();
}

class _FavroiteScreenState extends State<FavroiteScreen> {

  final NewsController newsController = Get.find<NewsController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: GradientText(
          BaseStrings.favoriteNews,
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
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          newsController.items.isNotEmpty ?
          Expanded(
            child: ListView.builder(
              itemCount: newsController.items.length ?? 0 ,
              itemBuilder: (context, index) {
                var item =  newsController.items[index];
                return
                  notificationListing(context: context,title:item.title, imageUrl: item.photoUrl);
              },
            ),
          )  : const Center(child: Text(BaseStrings.noDataFound,style: TextStyle(color: BaseColors.blackColors),)),
        ],
      ),
    );
  }
}
