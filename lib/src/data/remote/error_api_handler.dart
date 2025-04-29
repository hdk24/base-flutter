import 'dart:io';

import 'package:base_flutter/src/core/constants/http_constant.dart';
import 'package:base_flutter/src/domain/entities/failure.dart';
import 'package:dio/dio.dart';

class ErrorApiHandler {
  // map exception to failure model
  static Failure getException(error) {
    try {
      if (error is DioException) {
        return _getDioException(error);
      } else {
        return const Failure(code: 500, message: HttpConstant.unknownError);
      }
    } on FormatException {
      return const Failure(code: 500, message: HttpConstant.badFormat);
    } catch (_) {
      return const Failure(code: 500, message: HttpConstant.unknownError);
    }
  }

  // get dio exception and map to failure model
  static Failure _getDioException(DioException error) {
    // request cancelled
    if (error.type == DioExceptionType.cancel) {
      return const Failure(code: 499, message: HttpConstant.requestCancelled);
    }

    // timeout
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return const Failure(code: 408, message: HttpConstant.timeout);
    }

    // bad response
    if (error.type == DioExceptionType.badResponse && error.response != null) {
      return Failure(
        message: error.response?.statusMessage ?? HttpConstant.unknownError,
        code: error.response?.statusCode ?? 500,
      );
    }

    // connection error
    if (error.type == DioExceptionType.connectionError ||
        error.error is SocketException ||
        error.error is HttpException) {
      return const Failure(code: 0, message: HttpConstant.noInternetConnection);
    }

    return const Failure(code: 500, message: HttpConstant.unknownError);
  }
}
