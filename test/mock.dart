// region data
// mock dio http client
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class RequestOptionMock extends Mock implements RequestOptions {
  // mock preserveHeaderCase,
  // when mock request options headers.preserveHeaderCase will null,
  // uncomment when test failed cause response option null
  @override
  bool get preserveHeaderCase => true;
}
