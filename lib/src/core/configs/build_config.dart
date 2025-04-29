class BuildConfig {
  // app config
  static const String APP_ID = String.fromEnvironment("APP_ID");
  static const String APP_NAME = String.fromEnvironment("APP_NAME");

  // api config
  static const String BASE_API = String.fromEnvironment("BASE_API");
  static const String APP_SECRET = String.fromEnvironment("APP_SECRET");

  // firebase config
  static const String FIREBASE_ANDROID_API_KEY =
      String.fromEnvironment("FIREBASE_ANDROID_API_KEY");
  static const String FIREBASE_ANDROID_APP_ID =
      String.fromEnvironment("FIREBASE_ANDROID_APP_ID");
  static const String FIREBASE_IOS_API_KEY =
      String.fromEnvironment("FIREBASE_IOS_API_KEY");
  static const String FIREBASE_IOS_APP_ID =
      String.fromEnvironment("FIREBASE_IOS_APP_ID");
  static const String FIREBASE_SENDER_ID =
      String.fromEnvironment("FIREBASE_SENDER_ID");
  static const String FIREBASE_PROJECT_ID =
      String.fromEnvironment("FIREBASE_PROJECT_ID");
  static const String FIREBASE_STORAGE_BUCKET =
      String.fromEnvironment("FIREBASE_STORAGE_BUCKET");
}
