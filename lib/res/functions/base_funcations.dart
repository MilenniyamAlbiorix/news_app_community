import 'package:flutter/material.dart';
import '../enums/enums.dart';


   ThemeData getTheme({required BuildContext context}) {
     return Theme.of(context);
   }


void showCustomSnackBar(
    {required BuildContext context,required String message,required SnackBarType type}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          type == SnackBarType.success ? Icons.check_circle : Icons.error,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
      ],
    ),
    backgroundColor: type == SnackBarType.success ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


String handleStatusCode(int statusCode) {
  switch (statusCode) {
    case 200:
      return 'Success';
    case 400:
      return 'Bad Request: The server could not understand the request.';
    case 401:
      return 'Unauthorized: Access is denied due to invalid credentials.';
    case 403:
      return 'Forbidden: You do not have permission to access this resource.';
    case 404:
      return 'Not Found: The requested resource could not be found.';
    case 429:
      return 'Too Many Requests: You have sent too many requests in a given amount of time. Please wait and try again later.';
    case 500:
      return 'Internal Server Error: The server encountered an error.';
    default:
      return 'Failed with status code: $statusCode';
  }
}

