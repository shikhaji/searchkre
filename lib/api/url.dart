import 'dart:core';

class EndPoints {
  static const String baseUrl = "https://searchkarein.com/android";

  static const String mobileVerify = '$baseUrl/verify_mobile';
  static const String register = '$baseUrl/candidate_registration_form';
  static const String login = '$baseUrl/user_login';
  static const String getState = '$baseUrl/get_states';
  static const String getCity = '$baseUrl/get_district';
  static const String resetPassword = '$baseUrl/update_new_password';
}
