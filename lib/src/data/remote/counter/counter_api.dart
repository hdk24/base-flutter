import 'package:base_flutter/src/core/configs/build_config.dart';
import 'package:base_flutter/src/data/mapper/counter_mapper.dart';
import 'package:base_flutter/src/data/remote/api_result.dart';
import 'package:base_flutter/src/data/remote/counter/counter_api_source.dart';
import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:dio/dio.dart';

class CounterApi extends ApiResult implements CounterApiSource {
  final Dio _client;

  CounterApi({required Dio dio}) : _client = dio;

  @override
  Future<Result<int>> getCounterValue() async {
    final response = await getApiResult(
      _client.get("/hdk24/${BuildConfig.APP_SECRET}"),
      converter: (data) => CounterMapper.mapToDomain(data),
    );
    return response;
  }

  @override
  Future<Result<int>> updateCounterValue({required int value}) async {
    final payload = {"current_value": value};
    final response = await getApiResult(
      _client.post("/hdk24/${BuildConfig.APP_SECRET}/update", data: payload),
      converter: (data) => CounterMapper.mapToDomain(data),
    );
    return response;
  }
}
