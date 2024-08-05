
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/repositories/top_headline/top_headline_repo.dart';

import '../../Data/service/News_services.dart';

class TopHeadlineRepoImpl implements TopHeadlineRepo {
  final NewsServices service;

  TopHeadlineRepoImpl(this.service);

  @override
  Future<TopHeadlines> getTopHeadline() async {
    return service.fetchTopHeadlines();
  }
}
