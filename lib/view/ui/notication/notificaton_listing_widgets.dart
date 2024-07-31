import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/res/functions/base_funcations.dart';
import 'package:news_app_community/utils/extensions/base_extensions.dart';
import 'package:readmore/readmore.dart';

Widget notificationListing({required BuildContext context}) {
  return AnimatedContainer(
    height: 280.h,
    duration: const Duration(milliseconds: 200),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          BaseAssets.frame,
          height: 128.h,
        ),
        10.toVSB,
        Text(
          "Monday, 10 May 2021",
          style: getTheme(context: context).textTheme.titleMedium?.copyWith(
              color: BaseColors.backBtnColor,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp),
        ),
        4.toVSB,
        Text(
          "WHO classifies triple-mutant Covid variant from India as global health risk",
          style: getTheme(context: context).textTheme.titleMedium?.copyWith(
              color: BaseColors.hotUpdateNewsTxt,
              fontSize: 14.sp,
              fontFamily: BaseStrings.nunito,fontWeight: FontWeight.w600),
        ),
         ReadMoreText(
          style: getTheme(context: context).textTheme.labelMedium?.copyWith(color:BaseColors.blackColors,fontWeight: FontWeight.w400,fontSize: 14.sp),
            trimMode: TrimMode.Line,
            trimLines: 3,
            trimLength: 40,
          trimExpandedText: "Read less",
          trimCollapsedText: "Read More",
          moreStyle: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.normal),
          lessStyle: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.normal),
            "A World Health Organization official said Monday it is reclassifying the highly contagious triple-mutant Covid variant spreading in India as a “variant of concern,” indicating that it’s become a  "),
         Text("Published by Berkeley Lovelace Jr.",  style: getTheme(context: context).textTheme.labelMedium?.copyWith(color:BaseColors.backBtnColor,fontWeight: FontWeight.w700,fontSize: 12.sp,fontFamily: BaseStrings.nunito),
  ),
      ],
    ),
  ).paddingSymmetric(horizontal: 15);
}
