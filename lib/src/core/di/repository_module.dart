import 'package:base_flutter/src/core/di/injector.dart';
import 'package:base_flutter/src/data/repository/counter_repository_impl.dart';
import 'package:base_flutter/src/domain/repository/counter_repository.dart';

class RepositoryModule {
  static void load() {
    injector.registerFactory<CounterRepository>(
      () => CounterRepositoryImpl(
        counterApiSource: injector(),
        appPreferenceSource: injector(),
      ),
    );
  }
}
