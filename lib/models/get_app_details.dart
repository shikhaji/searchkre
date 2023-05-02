// To parse this JSON data, do
//
//     final getAppDetails = getAppDetailsFromJson(jsonString);

import 'dart:convert';

GetAppDetails getAppDetailsFromJson(String str) => GetAppDetails.fromJson(json.decode(str));

String getAppDetailsToJson(GetAppDetails data) => json.encode(data.toJson());

class GetAppDetails {
  int status;
  String message;
  Logo logo;

  GetAppDetails({
    required this.status,
    required this.message,
    required this.logo,
  });

  factory GetAppDetails.fromJson(Map<String, dynamic> json) => GetAppDetails(
    status: json["status"],
    message: json["message"],
    logo: Logo.fromJson(json["LOGO"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "LOGO": logo.toJson(),
  };
}

class Logo {
  String profileId;
  DateTime profileTt;
  String orgName;
  String orgEmail;
  String orgAltEmail;
  String orgPhone;
  String orgAltPhone;
  String orgAddress;
  String keyId;
  String keySecret;
  String appUrl;
  String singleNotice;
  String orgAbout;
  String orgPrivacyPolicy;
  String orgTermsConditionShortDesc;
  String orgTermsConditions2;
  String referalAmount;

  Logo({
    required this.profileId,
    required this.profileTt,
    required this.orgName,
    required this.orgEmail,
    required this.orgAltEmail,
    required this.orgPhone,
    required this.orgAltPhone,
    required this.orgAddress,
    required this.keyId,
    required this.keySecret,
    required this.appUrl,
    required this.singleNotice,
    required this.orgAbout,
    required this.orgPrivacyPolicy,
    required this.orgTermsConditionShortDesc,
    required this.orgTermsConditions2,
    required this.referalAmount,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
    profileId: json["PROFILE_ID"],
    profileTt: DateTime.parse(json["PROFILE_TT"]),
    orgName: json["ORG_NAME"],
    orgEmail: json["ORG_EMAIL"],
    orgAltEmail: json["ORG_ALT_EMAIL"],
    orgPhone: json["ORG_PHONE"],
    orgAltPhone: json["ORG_ALT_PHONE"],
    orgAddress: json["ORG_ADDRESS"],
    keyId: json["KEY_ID"],
    keySecret: json["KEY_SECRET"],
    appUrl: json["APP_URL"],
    singleNotice: json["SINGLE_NOTICE"],
    orgAbout: json["ORG_ABOUT"],
    orgPrivacyPolicy: json["ORG_PRIVACY_POLICY"],
    orgTermsConditionShortDesc: json["ORG_TERMS_CONDITION_SHORT_DESC"],
    orgTermsConditions2: json["ORG_TERMS_CONDITIONS_2"],
    referalAmount: json["REFERAL_AMOUNT"],
  );

  Map<String, dynamic> toJson() => {
    "PROFILE_ID": profileId,
    "PROFILE_TT": profileTt.toIso8601String(),
    "ORG_NAME": orgName,
    "ORG_EMAIL": orgEmail,
    "ORG_ALT_EMAIL": orgAltEmail,
    "ORG_PHONE": orgPhone,
    "ORG_ALT_PHONE": orgAltPhone,
    "ORG_ADDRESS": orgAddress,
    "KEY_ID": keyId,
    "KEY_SECRET": keySecret,
    "APP_URL": appUrl,
    "SINGLE_NOTICE": singleNotice,
    "ORG_ABOUT": orgAbout,
    "ORG_PRIVACY_POLICY": orgPrivacyPolicy,
    "ORG_TERMS_CONDITION_SHORT_DESC": orgTermsConditionShortDesc,
    "ORG_TERMS_CONDITIONS_2": orgTermsConditions2,
    "REFERAL_AMOUNT": referalAmount,
  };
}
