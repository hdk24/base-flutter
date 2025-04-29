import 'package:base_flutter/src/data/preference/app_preference_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference extends AppPreferenceSource {
  // set preference key here
  static const COUNTER_KEY = "counter_key";

  AppPreference();

  @override
  Future<int> getCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(COUNTER_KEY) ?? 0;
  }

  @override
  Future<void> updateCounter(int count) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(COUNTER_KEY, count);
  }
}
