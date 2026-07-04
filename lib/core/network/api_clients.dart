import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/sources/local/shared_preference/shared_preference.dart';
import 'api_endpoints.dart';
import 'error_handle.dart';
import 'response_handle.dart';



class ApiClient {
  static const Duration _defaultTimeout = Duration(seconds: 30);
  static const Duration _uploadTimeout = Duration(seconds: 60);

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: _defaultTimeout,
      sendTimeout: _defaultTimeout,
      receiveTimeout: _defaultTimeout,
    ),
  );
  static Map<String, String>? headers;

  String _normalizePath(String endpoints) => endpoints.replaceFirst(RegExp(r'^/+'), '');

  Map<String, String> _buildHeaders({bool isMultipart = false}) {
    final mergedHeaders = <String, String>{
      ...?headers,
      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
    };
    return mergedHeaders;
  }

  static Future <void> headerSet(String? token) async {
    final tokn = await SharedPreferenceData.getToken();
    log(token ?? 'token');
    log(tokn ?? 'tokn');
    headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (tokn != null) 'Authorization': 'Bearer $tokn',
    };
  }

 Future<dynamic> getRequest({
    required String endpoints,
    Map<String, dynamic>? queryParameters,
  }) async {
   
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.get(
        _normalizePath(endpoints),
        queryParameters: queryParameters,
        options: Options(
          headers: _buildHeaders(),
        ),
      );
 
      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('GET request failed: $endpoints status=$status data=$data', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (GET): $e', stackTrace: st);
        throw Exception(ErrorHandle.formatErrorMessage(e));
      }
    }
  }


   Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,

    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.post(
        _normalizePath(endpoints),
        data: body ?? formData,
        options: Options(
          headers: _buildHeaders(isMultipart: formData != null),
        ),
      );
  
      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('POST request failed: $endpoints status=$status data=$data body=$body', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (POST): $e', stackTrace: st);
        throw Exception(ErrorHandle.formatErrorMessage(e));
      }
    }
  }


   Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.put(
        _normalizePath(endpoints),
        data: body,
        options: Options(
          headers: _buildHeaders(),
        ),
      );
      // debugPrint("\nPUT Request Successful: ${response.data}\n");
      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('PUT request failed: $endpoints status=$status data=$data body=$body', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (PUT): $e', stackTrace: st);
        throw Exception(ErrorHandle.formatErrorMessage(e));
      }
    }
  }

   Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
 
    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.patch(
        _normalizePath(endpoints),
        data: body ?? formData,
        options: Options(
          headers: _buildHeaders(isMultipart: formData != null),
          sendTimeout: formData != null ? _uploadTimeout : _defaultTimeout,
          receiveTimeout: formData != null ? _uploadTimeout : _defaultTimeout,
        ),
      );

      debugPrint("\nPATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('PATCH request failed: $endpoints status=$status data=$data body=$body', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (PATCH): $e', stackTrace: st);
        throw Exception(ErrorHandle.formatErrorMessage(e));
      }
    }
  }

  /// PATCH request
   Future<dynamic> deleteRequest({
    required String endpoints,

    // Map<String, String>? headers,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.delete(
        _normalizePath(endpoints),
        options: Options(
          headers: _buildHeaders(),
        ),
      );

      debugPrint("delete Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('DELETE request failed: $endpoints status=$status data=$data', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (DELETE): $e', stackTrace: st);
        throw Exception(ErrorHandle.formatErrorMessage(e));
      }
    }
  }
}
