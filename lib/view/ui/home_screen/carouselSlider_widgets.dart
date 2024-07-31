
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_community/res/const/assets.dart';



Widget carouselSliderWidgets(){
  return
    CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: [1,2,3,4,5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: 320,
              height: 240,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      BaseAssets.topNews, // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Picture above text
                  const Positioned(
                    bottom: 10,
                    left: 10,
                    child: SizedBox(
                      width: 240,
                      child: Text(
                        '“I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.”',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          backgroundColor: Colors.black54,
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