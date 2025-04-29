import 'package:base_flutter/src/domain/entities/result.dart';

abstract class CounterApiSource {
  Future<Result<int>> getCounterValue();

  Future<Result<int>> updateCounterValue({required int value});
}
