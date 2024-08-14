import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:news_app_community/Data/service/api_ends_points.dart';

import 'package:news_app_community/model/top_Headlines_model.dart';
import 'package:news_app_community/res/const/strings.dart';
import 'package:news_app_community/res/enums/enums.dart';
import '../../res/functions/base_funcations.dart';

class NewsApiServices {
  final DioClient dioClient;

  NewsApiServices(this.dioClient);



  ///fetchTopHeadline
 /* Future<TopHeadlines> fetchTopHeadlines() async {
    try {
      final response = await http.get(
        Uri.parse(BaseStrings.baseUrl + ApiEndPoints.getTopHeadline),
        headers: {
          'x-rapidapi-key': BaseStrings.apiKey,
          // 'x-rapidapi-host': BaseStrings.hosting,
        },
      );

      if (response.statusCode == 200) {
        return TopHeadlines.fromJson(jsonDecode(response.body));
      } else {
        // showCustomSnackBar(context: Get.context!,type: SnackBarType.error,message:.toString());
        throw Exception(handleStatusCode(response.statusCode));
      }
    } catch (error) {
      throw Exception('Error fetching top headlines: $error');
    }
  }*/
  Future<TopHeadlines> fetchTopHeadlines({String country = 'us'}) async {
    try {
      final response = await dioClient.dio.get(
        ApiEndPoints.getTopHeadline,
        queryParameters: {
          'country': country,
        },
      );

      if (response.statusCode == 200) {
        return TopHeadlines.fromJson(response.data);
      } else {
        throw Exception(handleStatusCode(int.parse(response.statusCode.toString())));
      }
    } catch (error) {
      throw Exception('Error fetching top headlines: $error');
    }
  }




  Future<TopHeadlines> fetchTopicHeadlines(String topic) async {
    try {
      final response = await dioClient.dio.get(
        ApiEndPoints.searchNewsList,
        queryParameters: {
          'q': topic,
        },
      );
      print("response data success************** ${response.data}");
      if (response.statusCode == 200) {
        return TopHeadlines.fromJson(response.data);
      } else {
        throw Exception('Failed to load topic headlines');
      }
    } on DioException catch (e) {
      showCustomSnackBar(context: Get.context!,type: SnackBarType.error,message: e.response!.data['message'].toString());
      if (e.response != null) {
        if (kDebugMode) {
          print('Response Data: ${e.response?.data}');
        }
        return e.response
            ?.data;
      }

      String errorDescription = handleDioError(e);
      throw Exception(errorDescription);
    } catch (e) {

      print('Error: $e');
      throw Exception('Unexpected error occurred.');
    }
  }


  Future<TopHeadlines> fetchSearchList(String query) async {
    try {
      final response = await  dioClient.dio.get(
        ApiEndPoints.searchNewsList,
        queryParameters: {
          'q': query,
        },
      );
      if (response.statusCode == 200) {
        return TopHeadlines.fromJson(response.data);
      } else {
        throw Exception('Failed to load search results');
      }
    } on DioException catch (e) {
      String errorDescription = handleDioError(e);
      if (kDebugMode) {
        print("log{$errorDescription}");
      }
      throw Exception(errorDescription);
    } catch (e) {
      throw Exception('Error: $e');
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

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BaseStrings.baseUrl,
        queryParameters: {
          'apiKey':BaseStrings.apiKey,
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  Dio get dio => _dio;
}