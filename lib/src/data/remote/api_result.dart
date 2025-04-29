import 'dart:convert';

import 'package:base_flutter/src/data/remote/error_api_handler.dart';
import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:dio/dio.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

abstract class ApiResult {
  /*
   * wrap api result and get exception in single place
   * unit test mock response with string but response type is hashMap
   */
  Future<Result<T>> getApiResult<T>(
    Future<Response<dynamic>> call, {
    required ResponseConverter<T> converter,
  }) async {
    try {
      var apiResponse = await call;
      if (apiResponse.data is! String?) {
        return SuccessState(data: converter(apiResponse.data));
      }

      final dynamic response;
      String? data = (apiResponse.data as String?);
      if (data == null || data.isEmpty == true) {
        response = jsonDecode(_getEmptyResponse());
      } else {
        response = jsonDecode(apiResponse.data);
      }
      return SuccessState(data: converter(response));
    } catch (e) {
      final exception = ErrorApiHandler.getException(e);
      return ErrorState(error: exception);
    }
  }

  // adjust json based on api response
  String _getEmptyResponse() {
    return json.encode({});
  }
}
