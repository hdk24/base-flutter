import 'package:base_flutter/src/core/configs/build_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _android;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _iOS;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions _android = FirebaseOptions(
    apiKey: BuildConfig.FIREBASE_ANDROID_API_KEY,
    appId: BuildConfig.FIREBASE_ANDROID_APP_ID,
    messagingSenderId: BuildConfig.FIREBASE_SENDER_ID,
    projectId: BuildConfig.FIREBASE_PROJECT_ID,
    storageBucket: BuildConfig.FIREBASE_STORAGE_BUCKET,
  );

  static const FirebaseOptions _iOS = FirebaseOptions(
    apiKey: BuildConfig.FIREBASE_IOS_API_KEY,
    appId: BuildConfig.FIREBASE_IOS_APP_ID,
    messagingSenderId: BuildConfig.FIREBASE_SENDER_ID,
    projectId: BuildConfig.FIREBASE_PROJECT_ID,
    storageBucket: BuildConfig.FIREBASE_STORAGE_BUCKET,
    iosBundleId: BuildConfig.APP_ID,
  );
}
