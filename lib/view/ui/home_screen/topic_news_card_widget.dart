import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/const/assets.dart';

Widget newsCardWidgets(
    {required String? imageUrl, required String? title, required String? author, required String? date}) {
  return Container(
    width: 345.w,
    height: 128.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      image:  DecorationImage(
        colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.color),
        onError: (exception, stackTrace) => Image.asset(BaseAssets.topNews),
        image: NetworkImage(imageUrl ?? ""),
        // Replace with your image asset
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
            top: 10,
            left: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                 width:  300.w,
                  child: Text(
                    maxLines: 2,
                    title ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            )),
         Positioned(
          bottom: 50,
          left: 10,
          child: Text(
            author ??"",
            style:  TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
         Positioned(
          bottom: 10,
          right: 10,
          child: Text(
            date ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    ),
  ).paddingSymmetric(vertical: 8.0,horizontal: 10);
}