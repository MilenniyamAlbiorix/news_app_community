import '../../model/top_Headlines_model.dart';

abstract class SearchNewsRepo {
  Future<TopHeadlines> getSearchNewSList(String query);
}