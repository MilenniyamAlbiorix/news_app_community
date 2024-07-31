import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class NewsController extends GetxController{


  final searchController = TextEditingController();
  var selectedIndex = Rxn<int>();

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