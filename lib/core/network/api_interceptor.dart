import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../storage/storage_service.dart';

/// Interceptor for injecting authorization tokens and logging requests/responses.
class ApiInterceptor extends Interceptor {
  final IStorageService _storageService;

  ApiInterceptor(this._storageService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storageService.getString(AppConstants.tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    if (kDebugMode) {
      debugPrint('[DIO -> REQ] ${options.method} ${options.uri}');
      if (options.data != null) {
        debugPrint('[DIO -> BODY] ${options.data}');
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[DIO <- RES] [${response.statusCode}] ${response.requestOptions.uri}');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[DIO !! ERR] [${err.response?.statusCode}] ${err.requestOptions.uri} -> ${err.message}');
    }
    return handler.next(err);
  }
}
