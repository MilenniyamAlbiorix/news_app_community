import 'package:http/http.dart' as http;
import 'package:news_app_community/Data/service/api_ends_points.dart';
import 'dart:convert';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/res/const/strings.dart';

class NewsServices {
  final String baseUrl;

  NewsServices(this.baseUrl);

  Future<TopHeadlines> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse(BaseStrings.baseUrl + ApiEndPoints.getTopHeadline),
      headers: {
        'x-rapidapi-key': BaseStrings.apiKey,
        'x-rapidapi-host': 'real-time-news-data.p.rapidapi.com', // Replace with your API host
      },
    );

    if (response.statusCode == 200) {
      return TopHeadlines.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
