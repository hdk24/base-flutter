import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:base_flutter/src/domain/repository/counter_repository.dart';

class ResetCounterValueUseCase {
  final CounterRepository _repository;

  ResetCounterValueUseCase({required CounterRepository repository})
      : _repository = repository;

  Future<Result<int>> execute() {
    return _repository.updateCounterValue(value: 0);
  }
}
