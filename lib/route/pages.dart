import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app_community/route/route.dart';
import 'package:news_app_community/view/ui/bottombar/bottombar_screen.dart';
import 'package:news_app_community/view/ui/home_screen/home_screen.dart';
import 'package:news_app_community/view/ui/news_details/news_details_screen.dart';
import 'package:news_app_community/view/ui/notication/notifaction_screen.dart';
import 'package:news_app_community/view/ui/search_Screen/search_Screen.dart';

class AppPages {

  static List<GetPage> pages = [
    GetPage(
      name: BaseRoute.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: BaseRoute.homeScreen,
      page: () =>  HomeScreen(),
    ),
    GetPage(
      name: BaseRoute.bottomBarScreen,
      page: () =>  const BottomBarScreen(),
    ),
    GetPage(
      name: BaseRoute.newsDetailsScreen,
      page: () =>  const NewsDetailsScreen(),
    ),
    GetPage(
      name: BaseRoute.searchScreen,
      page: () =>  const SearchScreen(),
    ),
  ];
}