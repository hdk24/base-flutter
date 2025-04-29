import 'package:base_flutter/src/core/di/injector.dart';
import 'package:base_flutter/src/presentation/screen/home/cubit/home_cubit.dart';
import 'package:base_flutter/src/presentation/utils/theme_config.dart';

class StateManagerModule {
  static void load() {
    injector.registerFactory(() => ThemeConfig());

    injector.registerFactory(
      () => HomeCubit(
        getCounterValueUseCase: injector(),
        incrementCounterValueUseCase: injector(),
        decrementCounterValueUseCase: injector(),
        resetCounterValueUseCase: injector(),
      ),
    );
  }
}
