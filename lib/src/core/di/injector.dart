import 'package:base_flutter/src/core/di/data_module.dart';
import 'package:base_flutter/src/core/di/network_module.dart';
import 'package:base_flutter/src/core/di/repository_module.dart';
import 'package:base_flutter/src/core/di/state_manager_module.dart';
import 'package:base_flutter/src/core/di/use_case_module.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

class AppInjector {
  // register all module and load on initial app
  static void init() {
    NetworkModule.load();
    DataModule.load();
    RepositoryModule.load();
    UseCaseModule.load();
    StateManagerModule.load();
  }
}
