import 'package:dio/dio.dart';


class ErrorHandle {
  static String handleDioError(DioException e) {
    final responseData = e.response?.data;
    final serverMessage = _extractMessage(responseData);
    final statusCode = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.badCertificate:
        return "Bad certificate. Please try again.";
      case DioExceptionType.badResponse:
        if (statusCode != null && statusCode >= 500) {
          return "Something went wrong. Please try again later.";
        }
        if (serverMessage != null && serverMessage.isNotEmpty) {
          return serverMessage;
        }
        if (statusCode == 404) {
          return "No data found.";
        }
        if (statusCode == 401 || statusCode == 403) {
          return "You are not authorized to access this data.";
        }
        if (statusCode != null) {
          return "Unable to load data right now.";
        }
        return "Something went wrong. Please try again.";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "Connection error. Please check your internet.";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout. Please try again.";
      case DioExceptionType.unknown:
        return serverMessage ?? "Unknown error occurred. Please try again.";
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      final message = data['message'];
      if (message != null) {
        return message.toString();
      }
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return null;
  }

  static String formatErrorMessage(Object error) {
    if (error is DioException) {
      return handleDioError(error);
    }

    final rawMessage = error.toString().trim();

    if (rawMessage.startsWith('Exception: ')) {
      return rawMessage.substring('Exception: '.length).trim();
    }

    if (rawMessage.startsWith('DioException')) {
      return "Connection error. Please check your internet.";
    }

    if (rawMessage.toLowerCase().contains('failed to load') ||
        rawMessage.toLowerCase().contains('server error')) {
      return "No data found.";
    }

    return rawMessage;
  }
}
