import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/repositories/top_headline/top_headline_repo.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/view/ui/Favorite_Screen/favroite_screen.dart';
import '../view/ui/home_screen/home_screen.dart';

class NewsController extends GetxController {
  final TopHeadlineRepo topHeadlineRepo;

   NewsController(this.topHeadlineRepo);

  final searchController = TextEditingController();
  RxInt selectedIndex = 0.obs;
  RxBool isPadding = false.obs;
  RxBool startAnimation = false.obs;
  RxBool isLoading = false.obs;

  var selectedCategory = 0.obs;
  var selectedChip = ''.obs;
  var selectedBottmBarIndex = 0.obs;
  var selectedChips = <String>[].obs;
  var topHeadlines = TopHeadlines().obs;

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
      selectedCategory.value = 0;
    } else {
      selectedCategory.value = index;
    }
  }

  @override
  void onInit() {
    selectedIndex.value = 0;
    fetchOffices();
    super.onInit();
    selectedBottmBarIndex.value =0;
    print("---------------------------------- : ${selectedIndex.value}");
  }


  Future<void> fetchOffices() async {
    try {
      isLoading(true);
      final result = await topHeadlineRepo.getTopHeadline();
   topHeadlines.value = result;
    } catch (e) {
     Get.snackbar(BaseStrings.error, e.toString());
    } finally {
      isLoading(false);
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

}
