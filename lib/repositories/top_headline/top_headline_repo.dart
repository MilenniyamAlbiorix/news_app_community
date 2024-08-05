import '../../model/top_Headlines_model.dart';

abstract class TopHeadlineRepo {
  Future<TopHeadlines> getTopHeadline();
}