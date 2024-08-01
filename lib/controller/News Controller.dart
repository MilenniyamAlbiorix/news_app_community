import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:news_app_community/view/ui/notication/notifaction_screen.dart';

import '../view/ui/home_screen/home_screen.dart';

class NewsController extends GetxController{


  final searchController = TextEditingController();
  var selectedIndex = Rxn<int>();
  var selectedChip = ''.obs;
  var selectedBottmBarIndex = 0.obs;
  var selectedChips = <String>[].obs;
  void selectBottomNavItem(int index) {
    selectedIndex.value = index;
    Get.offAll(screens[index], transition: Transition.fadeIn);
  }
  void selectMultiChip(String chip) {
    if (selectedChips.contains(chip)) {
      selectedChips.remove(chip);
    } else {
      selectedChips.add(chip);
    }
  }

  final List<Widget> screens = [
    HomeScreen(),
    const NotificationScreen(),
    HomeScreen(),
  ];

  final List<String> categories = [
    'WORLD',
    'NATIONAL',
    'BUSINESS',
    'TECHNOLOGY',
    'ENTERTAINMENT',
    'SPORTS',
    'SCIENCE',
    'HEALTH'
  ];



  void selectChip(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null; // Deselect if the same chip is tapped
    } else {
      selectedIndex.value = index;
    }
  }
  @override
  void onInit() {
    super.onInit();
  }
  @override
  void dispose() {

    super.dispose();
  }
}