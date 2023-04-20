import 'dart:convert';

GetCompanyProfile getCompanyProfileFromJson(String str) =>
    GetCompanyProfile.fromJson(json.decode(str));

String getCompanyProfileToJson(GetCompanyProfile data) =>
    json.encode(data.toJson());

class GetCompanyProfile {
  GetCompanyProfile({
    required this.status,
    required this.message,
  });

  int status;
  GetProfileData message;

  factory GetCompanyProfile.fromJson(Map<String, dynamic> json) =>
      GetCompanyProfile(
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
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchState,
    required this.branchCity,
    required this.branchContact,
    required this.branchEmail,
    required this.branchTt,
    required this.branchPassword,
    required this.branchStatus,
    required this.companyHrmType,
    required this.branchZipCode,
    required this.branchViewPassword,
    required this.categoryId,
    required this.branchKycStatus,
    required this.branchPhoto,
    required this.branchFirmName,
    required this.brandName,
  });

  String branchId;
  String branchName;
  String branchAddress;
  String branchState;
  String branchCity;
  String branchContact;
  String branchEmail;
  DateTime branchTt;
  String branchPassword;
  String branchStatus;
  String companyHrmType;
  String branchZipCode;
  String branchViewPassword;
  String categoryId;
  String branchKycStatus;
  String branchPhoto;
  String branchFirmName;
  String brandName;

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
        branchZipCode: json["BRANCH_ZIP_CODE"],
        branchViewPassword: json["BRANCH_VIEW_PASSWORD"],
        categoryId: json["CATEGORY_ID"],
        branchKycStatus: json["BRANCH_KYC_STATUS"],
        branchPhoto: json["BRANCH_PHOTO"],
        branchFirmName: json["BRANCH_FIRM_NAME"],
        brandName: json["brand_name"],
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
        "BRANCH_ZIP_CODE": branchZipCode,
        "BRANCH_VIEW_PASSWORD": branchViewPassword,
        "CATEGORY_ID": categoryId,
        "BRANCH_KYC_STATUS": branchKycStatus,
        "BRANCH_PHOTO": branchPhoto,
        "BRANCH_FIRM_NAME": branchFirmName,
        "brand_name": brandName,
      };
}
