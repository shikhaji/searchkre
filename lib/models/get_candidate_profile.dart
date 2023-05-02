// To parse this JSON data, do
//
//     final businessCategoryList = businessCategoryListFromJson(jsonString);

import 'dart:convert';

GetCandidateProfile businessCategoryListFromJson(String str) =>
    GetCandidateProfile.fromJson(json.decode(str));

String businessCategoryListToJson(GetCandidateProfile data) =>
    json.encode(data.toJson());

class GetCandidateProfile {
  GetCandidateProfile({
    required this.status,
    required this.message,
  });

  int status;
  GetProfileData message;

  factory GetCandidateProfile.fromJson(Map<String, dynamic> json) =>
      GetCandidateProfile(
        status: json["status"],
        message: GetProfileData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class GetProfileData {
  GetProfileData({
    required this.profile,
  });

  Profile profile;

  factory GetProfileData.fromJson(Map<String, dynamic> json) => GetProfileData(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    this.branchId,
    this.branchName,
    this.branchAddress,
    this.branchState,
    this.branchCity,
    this.branchContact,
    this.branchEmail,
    required this.branchTt,
    this.branchPassword,
    this.branchStatus,
    this.companyHrmType,
    this.branchFatherName,
    this.branchMotherName,
    this.branchZipCode,
    this.branchViewPassword,
    this.branchKycStatus,
    this.branchPhoto,
    this.branchCv,
    this.branchQualification,
    this.branchDob,
    this.branchExperience,
  });

  String? branchId;
  String? branchName;
  String? branchAddress;
  String? branchState;
  String? branchCity;
  String? branchContact;
  String? branchEmail;
  DateTime branchTt;
  String? branchPassword;
  String? branchStatus;
  String? companyHrmType;
  String? branchFatherName;
  String? branchMotherName;
  String? branchZipCode;
  String? branchViewPassword;
  String? branchKycStatus;
  String? branchPhoto;
  String? branchCv;
  String? branchQualification;
  String? branchDob;
  String? branchExperience;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        branchId: json["BRANCH_ID"],
        branchName: json["BRANCH_NAME"],
        branchAddress: json["BRANCH_ADDRESS"],
        branchState: json["BRANCH_STATE"],
        branchCity: json["BRANCH_CITY"],
        branchContact: json["BRANCH_CONTACT"],
        branchEmail: json["BRANCH_EMAIL"],
        branchTt: DateTime.parse(json["BRANCH_TT"]),
        branchPassword: json["BRANCH_PASSWORD"],
        branchStatus: json["BRANCH_STATUS"],
        companyHrmType: json["COMPANY_HRM_TYPE"],
        branchFatherName: json["BRANCH_FATHER_NAME"],
        branchMotherName: json["BRANCH_MOTHER_NAME"],
        branchZipCode: json["BRANCH_ZIP_CODE"],
        branchViewPassword: json["BRANCH_VIEW_PASSWORD"],
        branchKycStatus: json["BRANCH_KYC_STATUS"],
        branchPhoto: json["BRANCH_PHOTO"],
        branchCv: json["BRANCH_CV"],
        branchQualification: json["BRANCH_QUALIFICATION"],
        branchDob: json["BRANCH_DOB"],
        branchExperience: json["BRANCH_EXPERIENCE"],
      );

  Map<String, dynamic> toJson() => {
        "BRANCH_ID": branchId,
        "BRANCH_NAME": branchName,
        "BRANCH_ADDRESS": branchAddress,
        "BRANCH_STATE": branchState,
        "BRANCH_CITY": branchCity,
        "BRANCH_CONTACT": branchContact,
        "BRANCH_EMAIL": branchEmail,
        "BRANCH_TT": branchTt.toIso8601String(),
        "BRANCH_PASSWORD": branchPassword,
        "BRANCH_STATUS": branchStatus,
        "COMPANY_HRM_TYPE": companyHrmType,
        "BRANCH_FATHER_NAME": branchFatherName,
        "BRANCH_MOTHER_NAME": branchMotherName,
        "BRANCH_ZIP_CODE": branchZipCode,
        "BRANCH_VIEW_PASSWORD": branchViewPassword,
        "BRANCH_KYC_STATUS": branchKycStatus,
        "BRANCH_PHOTO": branchPhoto,
        "BRANCH_CV": branchCv,
        "BRANCH_QUALIFICATION": branchQualification,
        "BRANCH_DOB": branchDob,
        "BRANCH_EXPERIENCE": branchExperience,
      };
}
