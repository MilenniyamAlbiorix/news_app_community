import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/repositories/search_news/search_news_repo.dart';
import 'package:news_app_community/repositories/top_headline/top_headline_repo.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/view/ui/Favorite_Screen/favroite_screen.dart';
import '../view/ui/home_screen/home_screen.dart';

class NewsController extends GetxController {
  final TopHeadlineRepo topHeadlineRepo;

  final SearchNewsRepo? searchNewsRepo;

  NewsController({ required this.topHeadlineRepo,this.searchNewsRepo});

  final searchController = TextEditingController();
  RxInt selectedIndex = 0.obs;
  RxBool isPadding = false.obs;
  RxBool startAnimation = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSearchLoading = false.obs;

  var selectedCategory = 0.obs;
  var selectedChip = ''.obs;
  var selectedBottmBarIndex = 0.obs;
  var selectedChips = <String>[].obs;
  var topHeadlines = TopHeadlines().obs;

  var errorMessage = ''.obs;
  RxList<Datum> results = <Datum>[].obs;
  RxList<Datum> topicHeadline = <Datum>[].obs;
  var topHeadLineDetails ;

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
    selectedCategory.value = index;
    fetchArticlesByCategory(categories[index]);
  }

  @override
  void onInit() {
    selectedIndex.value = 0;
    fetchOffices();
    fetchArticlesByCategory(categories[selectedCategory.value]);
    super.onInit();
    selectedBottmBarIndex.value = 0;
  }

  Future<void> fetchOffices() async {
    try {
      isLoading(true);
      final result = await topHeadlineRepo.getTopHeadline();
      if (result.data != null && (result.data ?? []).isNotEmpty) {
        topHeadlines.value = result;
      }
      if (kDebugMode) {
        print(topHeadlines.value);
      }
    } catch (e) {
      Get.snackbar(BaseStrings.error, e.toString());
    } finally {
      isLoading(false);
    }
  }


  void searchNewsList(String query) async {
    isSearchLoading(true);
    errorMessage('');
    try {
      final searchResults = await searchNewsRepo?.getSearchNewSList(query);
      results.assignAll((searchResults?.data?? []));
    } catch (e) {
      Get.snackbar(BaseStrings.error, e.toString());
    } finally {
      isSearchLoading(false);
    }
  }

  Future<void> fetchArticlesByCategory(String category) async {
    try {
      final headlines = await topHeadlineRepo.getTopicHeadline(category);
      topicHeadline.value = headlines.data ?? [];
    } catch (e) {
      print('Error fetching articles: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
