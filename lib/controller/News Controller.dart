import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:news_app_community/view/ui/Favorite_Screen/favroite_screen.dart';
import 'package:news_app_community/view/ui/news_details/news_details_screen.dart';
import 'package:news_app_community/view/ui/notication/notifaction_screen.dart';
import 'package:news_app_community/view/ui/search_Screen/search_Screen.dart';
import '../view/ui/home_screen/home_screen.dart';

class NewsController extends GetxController {
  final searchController = TextEditingController();
  var selectedIndex = 0.obs;
  RxBool isPadding = false.obs;
  RxBool startAnimation = false.obs;

  var selectedCategory = Rxn<int>();
  var selectedChip = ''.obs;
  var selectedBottmBarIndex = 0.obs;
  var selectedChips = <String>[].obs;

  void selectMultiChip(String chip) {
    if (selectedChips.contains(chip)) {
      selectedChips.remove(chip);
    } else {
      selectedChips.add(chip);
    }
  }
  RxBool atEdge = false.obs;
  final List<Widget> screens = [
    HomeScreen(),
    const FavroiteScreen(),
    // const SearchScreen(),
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
    if (selectedCategory.value == index) {
      selectedCategory.value = null;
    } else {
      selectedCategory.value = index;
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
