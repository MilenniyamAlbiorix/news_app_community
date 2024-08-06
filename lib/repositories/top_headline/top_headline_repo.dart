import '../../model/top_Headlines_model.dart';

abstract class TopHeadlineRepo {
  Future<TopHeadlines> getTopHeadline();
  Future<TopHeadlines> getTopicHeadline(String topic);
}