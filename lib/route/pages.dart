import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app_community/route/route.dart';
import 'package:news_app_community/view/ui/home_screen/home_screen.dart';
import 'package:news_app_community/view/ui/notication/notifaction_screen.dart';

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
  ];
}