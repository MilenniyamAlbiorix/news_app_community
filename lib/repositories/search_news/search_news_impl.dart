import 'package:news_app_community/repositories/search_news/search_news_repo.dart';
import '../../Data/service/News_services.dart';
import '../../model/top_Headlines_model.dart';

class SearchNewsImpl implements SearchNewsRepo {
  final NewsServices service;

  SearchNewsImpl(this.service);

  @override
  Future<TopHeadlines> getSearchNewSList(String query) async {
    return service.fetchSearchList(query);
  }



}