import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:base_flutter/src/domain/repository/counter_repository.dart';

class DecrementCounterValueUseCase {
  final CounterRepository _repository;

  DecrementCounterValueUseCase({required CounterRepository repository})
      : _repository = repository;

  Future<Result<int>> execute() {
    return _repository.decrementValue();
  }
}
