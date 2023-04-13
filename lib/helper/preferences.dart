import 'package:shared_preferences/shared_preferences.dart';

Preferences preferences = Preferences.instance;

class Preferences {
  Preferences._();

  static final Preferences _instance = Preferences._();

  static SharedPreferences? _shared;

  final String _loginId = 'loginId';
  final String _loginType = 'loginType';
  final String _profileUpdate = 'profileUpdate';
  final String _isIntroCompleted = 'is_intro_completed';

  static Future<void> init() async {
    _shared = await SharedPreferences.getInstance();
  }

  set loginId(String value) => _shared?.setString(_loginId, value);
  String get loginId => _shared?.getString(_loginId) ?? '';

  set isIntroCompleted(bool value) =>
      _shared?.setBool(_isIntroCompleted, value);
  bool get isIntroCompleted => _shared?.getBool(_isIntroCompleted) ?? false;

  set loginType(String value) => _shared?.setString(_loginType, value);
  String get loginType => _shared?.getString(_loginType) ?? '';

  set profileUpdate(String value) => _shared?.setString(_profileUpdate, value);
  String get profileUpdate => _shared?.getString(_profileUpdate) ?? '';

  Future<void> clear() async {
    await _shared?.clear();
  }

  Future<void> logout() async {
    await _shared?.remove(_loginId);
    await _shared?.remove(_loginType);
  }

  static Preferences get instance => _instance;
}
