import 'package:shared_preferences/shared_preferences.dart';

Preferences preferences = Preferences.instance;

class Preferences {
  Preferences._();

  static final Preferences _instance = Preferences._();

  static SharedPreferences? _shared;

  final String _isLogged = 'is_logged';
  final String _token = 'token';
  final String _isIntroCompleted = 'is_intro_completed';

  static Future<void> init() async {
    _shared = await SharedPreferences.getInstance();
  }

  set isLogged(bool value) => _shared?.setBool(_isLogged, value);
  bool get isLogged => _shared?.getBool(_isLogged) ?? false;

  set isIntroCompleted(bool value) =>
      _shared?.setBool(_isIntroCompleted, value);
  bool get isIntroCompleted => _shared?.getBool(_isIntroCompleted) ?? false;

  set token(String? value) {
    if (value == null) return;
    _shared?.setString(_token, value);
  }

  String? get token => _shared?.getString(_token);

  Future<void> clear() async {
    await _shared?.clear();
  }

  static Preferences get instance => _instance;
}
