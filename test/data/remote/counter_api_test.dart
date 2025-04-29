import 'dart:convert';

import 'package:base_flutter/src/data/remote/counter/counter_api.dart';
import 'package:base_flutter/src/data/remote/counter/counter_api_source.dart';
import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';
import 'mock_counter_response.dart';

void main() {
  final Dio dio = Dio();
  late DioAdapterMock dioAdapterMock;
  late CounterApiSource counterApiSource;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    counterApiSource = CounterApi(dio: dio);
    registerFallbackValue(RequestOptionMock());
  });

  group('getCounterValue', () {
    test('should return 200', () async {
      // mock response
      when(() => dioAdapterMock.fetch(any(), any(), any())).thenAnswer(
        (_) async => ResponseBody.fromString(
          jsonEncode(counterJson),
          200,
        ),
      );

      // actual
      final response = await counterApiSource.getCounterValue();

      // expectation
      final expectValue = counterJson["current_value"];
      // assert
      expect(response, isA<SuccessState<int>>());
      expect((response as SuccessState<int>).data, expectValue);
    });

    test('should return 400', () async {
      // mock response
      when(() => dioAdapterMock.fetch(any(), any(), any()))
          .thenThrow(DioException(
        type: DioExceptionType.badResponse,
        response:
            Response(requestOptions: RequestOptionMock(), statusCode: 400),
        requestOptions: RequestOptionMock(),
      ));

      // actual
      final response = await counterApiSource.getCounterValue();

      // assert
      expect(response, isA<ErrorState>());
      expect((response as ErrorState).error.code, 400);
    });
  });
}
