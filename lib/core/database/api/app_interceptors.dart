import 'dart:io';

import 'package:chatgpt_app/core/database/api/end_points.dart';
import 'package:dio/dio.dart';

import '../../utils/custom_print.dart';

class AppIntercepters extends Interceptor {
  final Dio client;
  AppIntercepters({required this.client});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json;
    options.headers[ApiKeys.apiKey] = EndPoints.apiKey;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    CustomPrint.printFullText(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    CustomPrint.printFullText(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    if (err.response?.statusCode == 401) {}
    super.onError(err, handler);
  }
}
