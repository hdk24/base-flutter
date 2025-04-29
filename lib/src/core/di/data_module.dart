import 'package:base_flutter/src/core/di/injector.dart';
import 'package:base_flutter/src/data/preference/app_preference.dart';
import 'package:base_flutter/src/data/preference/app_preference_source.dart';
import 'package:base_flutter/src/data/remote/counter/counter_api.dart';
import 'package:base_flutter/src/data/remote/counter/counter_api_source.dart';

class DataModule {
  static void load() {
    //preference module
    injector.registerFactory<AppPreferenceSource>(() => AppPreference());

    // remote module
    injector.registerFactory<CounterApiSource>(
      () => CounterApi(dio: injector()),
    );
  }
}
