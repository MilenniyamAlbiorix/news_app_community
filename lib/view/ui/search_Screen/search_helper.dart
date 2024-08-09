import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/const/Colors.dart';
import '../../../res/const/assets.dart';
import '../../../res/const/strings.dart';
import '../../../res/functions/base_funcations.dart';

class  SearchHelper {

  Widget searchListWidgets({required BuildContext context,required TextEditingController controller}){
    return  TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: BaseStrings.search,
        suffixIcon: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            controller.clear();
          },
        ),
        hintStyle: getTheme(context: context)
            .textTheme
            .labelMedium
            ?.copyWith(
            fontSize: 12.sp,
            color: BaseColors.colorBorder),
        contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      controller: controller,
    );
  }
 Widget filterNews({GestureTapCallback? onTap,required BuildContext context,}){
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 32.h,
        width: 75.w,
        decoration:   const BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(22)),
          gradient: LinearGradient(colors: [BaseColors.gradintOne,BaseColors.gradintTwo]),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.filter_alt_rounded,color: BaseColors.whiteColor,size: 16,),
            Text(BaseStrings.filter, style: getTheme(context: context).textTheme.titleMedium?.copyWith(color: BaseColors.whiteColor,fontSize: 12.sp ),),
          ],
        ),
      ).paddingSymmetric(horizontal: 15),
    );
 }

Widget filterListingView(){
    return Container(
      width: 345,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: const DecorationImage(
          image: AssetImage(BaseAssets.frame),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      '5 things to know about the "conundrum" of lupus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              )),
          const Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              'Matt Villano',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              'Sunday, 9 May 2021',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ).paddingSymmetric(vertical: 8.0);
}

}