import 'package:base_flutter/src/core/configs/build_config.dart';
import 'package:base_flutter/src/core/constants/app_constant.dart';
import 'package:base_flutter/src/core/di/injector.dart';
import 'package:base_flutter/src/presentation/components/scrolls/scroll_behavior_util.dart';
import 'package:base_flutter/src/presentation/resources/themes.dart';
import 'package:base_flutter/src/presentation/routes/route_app.dart';
import 'package:base_flutter/src/presentation/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late ThemeConfig themeConfig;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    themeConfig = injector<ThemeConfig>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    themeConfig.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // change app theme
    themeConfig.isDarkTheme = kIsDarkTheme;

    // change system navigation bar color
    SystemChrome.setSystemUIOverlayStyle(
      ThemeRes.systemBarTheme(kIsDarkTheme),
    );
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeConfig>(create: (_) => themeConfig),
        Provider<RouteApp>(create: (_) => RouteApp()),
      ],
      child: _buildApp(),
    );
  }

  Widget _buildApp() {
    return Consumer<ThemeConfig>(
      builder: (context, value, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scrollBehavior: ScrollBehaviorUtil(),
          title: BuildConfig.APP_NAME,
          theme: ThemeRes.lightTheme,
          darkTheme: ThemeRes.darkTheme,
          themeMode: value.themeMode,
          routerConfig: context.read<RouteApp>().router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
