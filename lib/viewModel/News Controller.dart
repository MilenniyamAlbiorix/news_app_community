import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/repositories/search_news/search_news_repo.dart';
import 'package:news_app_community/repositories/top_headline/top_headline_repo.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/view/ui/Favorite_Screen/favroite_screen.dart';
import '../utils/widgets/debounce_widgets.dart';
import '../view/ui/home_screen/home_screen.dart';
import '../view/ui/search_Screen/search_Screen.dart';

class NewsController extends GetxController {
  final TopHeadlineRepo topHeadlineRepo;

  final SearchNewsRepo? searchNewsRepo;

  NewsController({required this.topHeadlineRepo, this.searchNewsRepo});

  final Rx<TextEditingController> searchController = TextEditingController().obs;


  RxInt selectedIndexes = 0.obs;
  RxBool isPadding = false.obs;
  RxBool startAnimation = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  RxBool isTopicLoading = false.obs;
  var selectedCategory = 0.obs;

  var selectedChips = <String>[].obs;
  RxList<Datum> topHeadlinesList = <Datum>[].obs;
  var errorMessage = ''.obs;
  RxList<Datum> results = <Datum>[].obs;
  RxList<Datum> topicHeadline = <Datum>[].obs;
  var topHeadLineDetails;

  final box = GetStorage();
  var items = <Datum>[].obs;

  RxBool atEdge = false.obs;
   RxList<Widget> screens = [
    HomeScreen(),
    const FavroiteScreen(),
    const SearchScreen(),
  ].obs;

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

  @override
  void onInit() {
    PageController(initialPage: 0);

     initDataAndApi();
    super.onInit();

  }

  Future<void> initDataAndApi() async {
    await fetchTopHeadline();

    // items.value = List<Datum>.from(box.read<List>('items') ?? []);
  }

  void selectMultiChip(String chip) {
    if (selectedChips.contains(chip)) {
      selectedChips.remove(chip);
    } else {
      selectedChips.add(chip);
    }
  }

  void selectChip(int index) {
    selectedCategory.value = index;
    fetchArticlesByCategory(categories[index]);
  }

  Future<void> fetchTopHeadline() async {
    isLoading(true);
    try {
      final response = await topHeadlineRepo.getTopHeadline();
      if (response.data != null && (response.data ?? []).isNotEmpty) {
        topHeadlinesList.addAll(response.data ?? []);
      }
      if (kDebugMode) {
        print("*********************************${topHeadlinesList.value}");
      }
    } catch (e) {
      // Get.snackbar(
      //   BaseStrings.error,
      //   e.toString(),
      // );
    } finally {
      isLoading(false);
    }
     await fetchArticlesByCategory(categories[selectedCategory.value]);
  }

  Future<void> searchNewsList(String query) async {
    isSearchLoading.value = true;
    errorMessage('');
    try {
      final searchResults = await searchNewsRepo?.getSearchNewSList(query);
      if (searchResults?.data != null) {
        results.assignAll(searchResults?.data ?? []);
      } else {
        results.clear();
      }
    } catch (e) {
      // Get.snackbar(BaseStrings.error, e.toString());
    } finally {
      isSearchLoading(false);
    }
  }

  Future<void> fetchArticlesByCategory(String category) async {
    isTopicLoading(true);
    try {
      final headlines = await topHeadlineRepo.getTopicHeadline(category);
      if (headlines.data != null || (headlines.data ?? []).isNotEmpty) {
        topicHeadline.addAll(headlines.data ?? []) ;
      }
       if (kDebugMode) {
        print("-----------------------------------:${topicHeadline.value}");
      }
    } catch (e) {
      GetSnackBar(
        title: BaseStrings.error,
        message: e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isTopicLoading(false);
    }
  }

  void addItem(List<Datum> item) {
    items.addAll(item);
    box.write('items', items);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
