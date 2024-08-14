import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/repositories/search_news/search_news_repo.dart';
import 'package:news_app_community/repositories/top_headline/top_headline_repo.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/view/ui/Favorite_Screen/favroite_screen.dart';
import '../res/functions/base_funcations.dart';
import '../utils/widgets/debounce_widgets.dart';
import '../view/ui/home_screen/home_screen.dart';
import '../view/ui/search_Screen/search_Screen.dart';

class NewsController extends GetxController {
  final TopHeadlineRepo topHeadlineRepo;

  final SearchNewsRepo? searchNewsRepo;

  NewsController({required this.topHeadlineRepo, this.searchNewsRepo});

  final Rx<TextEditingController> searchController =
      TextEditingController().obs;

  var selectedIndexes = 0.obs;
  RxBool isPadding = true.obs;
  RxBool startAnimation = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  RxBool isTopicLoading = false.obs;
  var selectedCategory = 0.obs;

  var selectedChips = <String>[].obs;
  RxList<Article> topHeadlinesList = <Article>[].obs;
  var errorMessage = ''.obs;
  RxList<Article> results = <Article>[].obs;
  RxList<Article> topicHeadline = <Article>[].obs;
   var topHeadLineDetails;

  final GetStorage storage = GetStorage();
  var items = <Article>[].obs;

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
     initDataAndApi();
    super.onInit();
    selectedIndexes.value = 0;
    if (kDebugMode) {
      print("************: ${selectedIndexes.value}");
    }
  }


  Future<void> initDataAndApi() async {
    await fetchTopHeadline();
    loadItemsFromStorage();
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
    isTopicLoading.value = true;

    try {
      final response = await topHeadlineRepo.getTopHeadline();
      if (response.articles != null && (response.articles ?? []).isNotEmpty) {
        topHeadlinesList.addAll(response.articles ?? []);
      }
      if (kDebugMode) {
        print("*********************************${topHeadlinesList.value}");
      }
    } catch (e) {
      /*   Get.snackbar(
        BaseStrings.error,
        e.toString(),
      );*/
    } finally {
      isTopicLoading.value = false;
      isLoading(false);
    }
     await fetchArticlesByCategory(categories[selectedCategory.value],);
  }

  Future<void> searchNewsList(String query, BuildContext context) async {
    if (query.length < 3) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warring'),
            content: const Text('Please enter at least 3 characters to search.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    else{
      isSearchLoading.value = true;
      errorMessage('');
      try {
        final searchResults = await searchNewsRepo?.getSearchNewSList(query);
        if (searchResults?.articles != null) {
          results.assignAll(searchResults?.articles ?? []);
        } else {
          results.clear();
        }
      } catch (e) {
         Get.snackbar(BaseStrings.error, e.toString());
      } finally {
        isSearchLoading(false);
      }
    }
  }

  Future<void> fetchArticlesByCategory(String category) async {
    isTopicLoading(true);
    topicHeadline.clear();
    try {
      final headlines = await topHeadlineRepo.getTopicHeadline(category);
      if (kDebugMode) {
        print("${headlines} Hedlines");
      }
      topicHeadline.clear();
      if (headlines.articles != null || (headlines.articles ?? []).isNotEmpty) {
        topicHeadline.addAll(headlines.articles ?? []);
      }
      if (kDebugMode) {
        print("-----------------------------------:${topicHeadline.value}");
      }
    } catch (e) {
      print("Error ${e.toString()}");
      GetSnackBar(
        title: BaseStrings.error,
        message: e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      print("Finally Block called");
      isTopicLoading(false);
    }
  }

  void addItem(List<Article> newItems) {
    final List<dynamic> storedItems =
        storage.read<List<dynamic>>('items') ?? [];
    final List<Article> existingItems = storedItems.map((item) {
      return Article.fromJson(item as Map<String, dynamic>);
    }).toList();
    existingItems.addAll(newItems);
    final List<Map<String, dynamic>> updatedItems = existingItems.map((item) {
      return item.toJson();
    }).toList();

    storage.write('items', updatedItems);
  }

  void loadItemsFromStorage() {
    final List<dynamic> storedItems =
        storage.read<List<dynamic>>('items') ?? [];

    final List<Article> itemsList = storedItems.map((item) {
      return Article.fromJson(item as Map<String, dynamic>);
    }).toList();

    items.value.assignAll(itemsList);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
