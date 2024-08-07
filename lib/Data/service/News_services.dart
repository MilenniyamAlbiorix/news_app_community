import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_community/Data/service/api_ends_points.dart';
import 'dart:convert';
import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/res/const/strings.dart';

class NewsServices {
  final String baseUrl;

  NewsServices(this.baseUrl);

  final Dio dio = Dio();

  ///fetchTopHeadline
  Future<TopHeadlines> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse(BaseStrings.baseUrl + ApiEndPoints.getTopHeadline),
      headers: {
        'x-rapidapi-key': BaseStrings.apiKey,
        'x-rapidapi-host': BaseStrings.hosting,
      },
    );
    if (response.statusCode == 200) {
      return TopHeadlines.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }


  Future<TopHeadlines> fetchSearchList(String query) async {
    try {
      final response = await dio.get(
        baseUrl + ApiEndPoints.searchNewsList,
        queryParameters: {
          'query': query,
          'limit': 500,
          'time_published': 'anytime',
          'country': 'US',
          'lang': 'en',
        },
        options: Options(
          headers: {
            'x-rapidapi-host': BaseStrings.hosting,
            'x-rapidapi-key': BaseStrings.apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        return TopHeadlines.fromJson(response.data);
      } else {
        throw Exception('Failed to load search results');
      }
    } on DioException catch (e) {
      String errorDescription = handleDioError(e);
      throw Exception(errorDescription);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<TopHeadlines> fetchTopicHeadlines(String topic) async {
    try {
      final response = await dio.get(
        baseUrl + ApiEndPoints.getTopicHeadlineNews,
        queryParameters: {
          'topic': topic,
          'limit': 500,
          'country': 'US',
          'lang': 'en',
        },
        options: Options(
          headers: {
            'x-rapidapi-host': BaseStrings.hosting,
            'x-rapidapi-key': BaseStrings.apiKey,
          },
        ),
      );
      if (response.statusCode == 200) {
        return TopHeadlines.fromJson(response.data);
      } else {
        throw Exception('Failed to load topic headlines');
      }
    } on DioException catch (e) {
      String errorDescription = handleDioError(e);
      print('Error: $errorDescription');
      throw Exception(errorDescription);
    } catch (e) {
      print('Error: $e');
      throw Exception('Unexpected error occurred.');
    }
  }

  String handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again later.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again later.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again later.';
      case DioExceptionType.badResponse:
        if (e.response != null && e.response?.statusCode == 404) {
          return 'Resource not found.';
        } else {
          return 'Received invalid status code: ${e.response?.statusCode}';
        }
      case DioExceptionType.cancel:
        return 'Request to API server was cancelled.';
      case DioExceptionType.unknown:
        return 'Network error. Please check your internet connection.';
      default:
        return 'Unexpected error occurred.';
    }
  }


}
