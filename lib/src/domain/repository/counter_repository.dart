import 'package:base_flutter/src/domain/entities/result.dart';

abstract class CounterRepository {
  Future<Result<int>> getCounterValue();

  Future<Result<int>> incrementValue();

  Future<Result<int>> decrementValue();

  Future<Result<int>> updateCounterValue({required int value});
}
