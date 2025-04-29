import 'package:base_flutter/src/core/di/injector.dart';
import 'package:base_flutter/src/domain/usecase/counter/decrement_counter_value_use_case.dart';
import 'package:base_flutter/src/domain/usecase/counter/get_counter_value_use_case.dart';
import 'package:base_flutter/src/domain/usecase/counter/increment_counter_value_use_case.dart';
import 'package:base_flutter/src/domain/usecase/counter/reset_counter_value_use_case.dart';

class UseCaseModule {
  static void load() {
    injector.registerFactory(
      () => GetCounterValueUseCase(repository: injector()),
    );

    injector.registerFactory(
      () => IncrementCounterValueUseCase(repository: injector()),
    );

    injector.registerFactory(
      () => DecrementCounterValueUseCase(repository: injector()),
    );

    injector.registerFactory(
      () => ResetCounterValueUseCase(repository: injector()),
    );
  }
}
