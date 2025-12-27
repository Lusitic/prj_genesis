import 'package:shared_preferences/shared_preferences.dart';

Future<void> resetOnboardingForDebug() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('onboarding_done');
}

class AppPrefs {
  static const _kOnboardingDone = 'onboarding_done';

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnboardingDone) ?? false;
  }

  static Future<void> setOnboardingDone(bool done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingDone, done);
  }
}