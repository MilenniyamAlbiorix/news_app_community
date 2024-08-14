import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_community/res/const/Colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme:  IconThemeData(color: BaseColors.blackColors, size: 24.sp),
        selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 10.sp),
        selectedFontSize: 10.sp,
        iconSize: 25.h,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 0.0,
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}