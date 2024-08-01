
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_community/res/const/assets.dart';



Widget carouselSliderWidgets(){
  return

    CarouselSlider(
      options: CarouselOptions(
        height: 240.0.h,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
      ),
      items: [1,2].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      BaseAssets.topNews, // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: (200 - 60) / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        width: 240.w,
                        child: Text(
                          "Crypto investors should be prepared to lose all their money, BOE governor says"
                          ,style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,

                        ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(

                    bottom: 0,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 40),
                      child: SizedBox(
                        width: 240.w,
                        child: Text(
                          '“I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.”',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
}