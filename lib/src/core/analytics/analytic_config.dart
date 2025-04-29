import 'dart:io';

import 'package:base_flutter/src/core/configs/build_config.dart';
import 'package:base_flutter/src/core/configs/firebase_config.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class Analytics {
  static final FirebaseAnalytics firebase = FirebaseAnalytics.instance;
  static late FacebookAppEvents facebook;

  static Future<void> initialize() async {
    // initialize firebase analytics
    await Firebase.initializeApp(
      name: BuildConfig.APP_NAME,
      options: FirebaseConfig.currentPlatform,
    );

    // initialize facebook analytics
    facebook = FacebookAppEvents();

    // set tracking collection
    bool enabled = Platform.isAndroid ? kReleaseMode : true;
    firebase.setAnalyticsCollectionEnabled(enabled);
    facebook.setAutoLogAppEventsEnabled(enabled);
  }
}
