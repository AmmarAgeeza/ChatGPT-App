import 'dart:convert';
import 'dart:core';

import 'package:chatgpt_app/core/utils/custom_print.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../error/exceptions.dart';
import '../../network/netwok_info.dart';
import '../../services/service_locator.dart';
import '../../utils/app_strings.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;
  final NetworkInfo networkInfo;
  DioConsumer({required this.client, required this.networkInfo}) {
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false;

    client.interceptors.add(sl<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(sl<LogInterceptor>());
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      // if (await networkInfo.isConnected) {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return decodeResponse(response);
      // } else {
      // throw const NoInternetConnectionException(
      // AppStrings.noInternetConnection);
      // }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      CustomPrint.printTest(
        "networkInfo.isConnected: ${await networkInfo.isConnected}",
      );
      // if (await networkInfo.isConnected) {
      final response = await client.post(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );

      return decodeResponse(response);
      // }
      // else {
      //   throw const NoInternetConnectionException(
      //     AppStrings.noInternetConnection,
      //   );
      // }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic decodeResponse(Response response) {
    return jsonDecode(response.data.toString());
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.delete(
          path,
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameters,
        );
        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
          AppStrings.noInternetConnection,
        );
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool responseIsParsing = true,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // if (await networkInfo.isConnected) {
      final response = await client.patch(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return decodeResponse(response);
      // } else {
      // throw const NoInternetConnectionException(
      // AppStrings.noInternetConnection);
      // }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.put(
          path,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
          AppStrings.noInternetConnection,
        );
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> download(
    String path,
    String savePath, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await client.download(
          path,
          savePath,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return decodeResponse(response);
      } else {
        throw const NoInternetConnectionException(
          AppStrings.noInternetConnection,
        );
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleDioError(DioException error) {
    var errorResponse = jsonDecode(error.response?.data ?? "{}");
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        throw FetchDataException(
          errorResponse['error']?["message"] ?? "Opps something went wrong",
        );
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.notFound:
            throw NotFoundException(errorResponse['error']["message"]);
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException(errorResponse['error']["message"]);
          case StatusCode.badRequest:
            throw BadRequestException(errorResponse['error']["message"]);
          case StatusCode.conflict:
            throw ConflictException(errorResponse['error']["message"]);
          case StatusCode.internalServerError:
            throw InternalServerErrorException(errorResponse['message']);
          case StatusCode.gatewayServerError:
            throw InternalServerErrorException(
              errorResponse['error']["message"],
            );
          case StatusCode.requestEntityTooLarge:
            throw InternalServerErrorException(
              errorResponse['error']["message"],
            );
          default:
            throw ServerException("Opps something went wrong");
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException(
          AppStrings.noInternetConnection,
        );
    }
  }
}
