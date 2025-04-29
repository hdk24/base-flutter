import 'package:flutter/services.dart';

class PlatformUtil {
  static const MethodChannel _channel = MethodChannel("com.hdk24.flutter");

  static Future<void> openAppSettings({bool asAnotherTask = false}) async {
    _channel.invokeMethod(
      'open_settings',
      {'asAnotherTask': asAnotherTask},
    );
  }

  static void openUrl(String url, {bool inApp = true}) async {
    _channel.invokeMethod(
      'open_url',
      {'urlLink': url, 'inAppBrowser': inApp},
    );
  }

  static Future<String> openFile(String path, String type) async {
    try {
      return await _channel.invokeMethod(
        'open_file',
        {'file_path': path, 'type': type},
      );
    } on PlatformException catch (_) {
      return 'No activity found to handle this file.';
    }
  }

  static Future<void> shareText({required String text}) async {
    await _channel.invokeMethod(
      'share_text',
      {'text': text},
    );
  }
}
