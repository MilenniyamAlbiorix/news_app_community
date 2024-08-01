import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_community/res/const/Colors.dart';
import 'package:news_app_community/res/const/assets.dart';
import 'package:news_app_community/res/functions/base_funcations.dart';


class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
            onPressed: () {},
            child: Image.asset(
              BaseAssets.group,
              height: 18.5.h,
              width: 22.5.w,
            ),
          ),).paddingSymmetric(horizontal: 10, vertical: 20),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              fit: BoxFit.cover,
              BaseAssets.rectangleImage,
              width: 375.w,
              height: 300.h,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: BaseColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              height: 400.h,
              child: ListView(
                children:  [
                  RichText(
                    text:  TextSpan(
                      style: getTheme(context: context).textTheme.titleMedium?.copyWith(color: BaseColors.backBtnColor,fontSize: 14.sp,fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: 'LONDON',
                          style: getTheme(context: context).textTheme.titleMedium?.copyWith(color: BaseColors.backBtnColor,fontSize: 14.sp,fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ' — Cryptocurrencies “have no intrinsic value” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey said. Digital currencies like bitcoin, ether and even dogecoin have been on a tear this year, reminding some investors of the 2017 crypto bubble in which bitcoin blasted toward \$20,000, only to sink as low as \$3,122 a year later. Asked at a press conference Thursday about the rising value of cryptocurrencies, Bailey said: “They have no intrinsic value. That doesn’t mean to say people don’t put value on them, because they can have extrinsic value. But they have no intrinsic value.” “I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.” Bailey’s comments echoed a similar warning from the U.K.’s Financial Conduct Authority. “Investing in cryptoassets, or investments and lending linked to them, generally involves taking very high risks with investors’ money,” the financial services watchdog said in January. “If consumers invest in these types of product, they should be prepared to lose all their money.” Bailey, who was formerly the chief executive of the FCA, has long been a skeptic of crypto. In 2017, he warned: “If you want to invest in bitcoin, be prepared to lose all your money.”',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ).paddingOnly(top: 40,left: 15,right: 15,bottom: 8),
            ),
          ),
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 311.w,
                    height: 141.w,
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
                                ?.copyWith(color: BaseColors.backBtnColor,fontSize: 12),
                          ),

                          Text(
                            "Crypto investors should be prepared to lose all their money, BOE governor says",
                            style: getTheme(context: context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: BaseColors.backBtnColor,fontSize: 16.sp),
                          ),
                          Text(
                            "Published by Ryan Browne",
                            style: getTheme(context: context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: BaseColors.backBtnColor,fontSize: 10,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
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
                      width:0,
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
          )
        ],
      ),
    );
  }
}
