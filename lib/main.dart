import 'package:base_flutter/src/app.dart';
import 'package:base_flutter/src/core/di/injector.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init analytics
  // uncomment to enable analytics
  // await Analytics.initialize();

  // init service locator
  AppInjector.init();

  // run app
  runApp(const App());
}
