import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:base_flutter/src/domain/repository/counter_repository.dart';

class GetCounterValueUseCase {
  final CounterRepository _repository;

  GetCounterValueUseCase({required CounterRepository repository})
      : _repository = repository;

  Future<Result<int>> execute() {
    return _repository.getCounterValue();
  }
}
