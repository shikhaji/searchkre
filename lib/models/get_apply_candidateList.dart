// To parse this JSON data, do
//
//     final getAllCandidateApplyList = getAllCandidateApplyListFromJson(jsonString);

import 'dart:convert';

GetAllCandidateApplyList getAllCandidateApplyListFromJson(String str) =>
    GetAllCandidateApplyList.fromJson(json.decode(str));

String getAllCandidateApplyListToJson(GetAllCandidateApplyList data) =>
    json.encode(data.toJson());

class GetAllCandidateApplyList {
  int status;
  CandidateList message;

  GetAllCandidateApplyList({
    required this.status,
    required this.message,
  });

  factory GetAllCandidateApplyList.fromJson(Map<String, dynamic> json) =>
      GetAllCandidateApplyList(
        status: json["status"],
        message: CandidateList.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class CandidateList {
  List<Job> job;

  CandidateList({
    required this.job,
  });

  factory CandidateList.fromJson(Map<String, dynamic> json) => CandidateList(
        job: List<Job>.from(json["job"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "job": List<dynamic>.from(job.map((x) => x.toJson())),
      };
}

class Job {
  String cjalId;
  String cjalPostId;
  String cjalLoginId;
  DateTime cjalApplyDate;
  String cjalStatus;
  String vapId;
  DateTime vapTt;
  String vapLoginId;
  String vapTitle;
  String vapDesc;
  String vapVideoType;
  String vapImage;
  String vapVideoUrl;
  String vapLike;
  String vapComment;
  String branchId;
  dynamic firmId;
  String branchName;
  dynamic branchCode;
  String branchAddress;
  String branchState;
  String branchCity;
  String branchContact;
  dynamic branchPhone;
  String branchEmail;
  dynamic branchTarget;
  dynamic branchCreated;
  DateTime branchTt;
  dynamic branchUsername;
  String branchPassword;
  String branchStatus;
  String companyHrmType;
  String branchFatherName;
  String branchMotherName;
  dynamic sponserId;
  String branchZipCode;
  dynamic startDate;
  String branchViewPassword;
  String categoryId;
  String branchKycStatus;
  String sponserName;
  String branchPhoto;
  String branchCv;
  String branchFirmName;
  String branchQualification;
  String branchDob;
  String branchExperience;

  Job({
    required this.cjalId,
    required this.cjalPostId,
    required this.cjalLoginId,
    required this.cjalApplyDate,
    required this.cjalStatus,
    required this.vapId,
    required this.vapTt,
    required this.vapLoginId,
    required this.vapTitle,
    required this.vapDesc,
    required this.vapVideoType,
    required this.vapImage,
    required this.vapVideoUrl,
    required this.vapLike,
    required this.vapComment,
    required this.branchId,
    this.firmId,
    required this.branchName,
    this.branchCode,
    required this.branchAddress,
    required this.branchState,
    required this.branchCity,
    required this.branchContact,
    this.branchPhone,
    required this.branchEmail,
    this.branchTarget,
    this.branchCreated,
    required this.branchTt,
    this.branchUsername,
    required this.branchPassword,
    required this.branchStatus,
    required this.companyHrmType,
    required this.branchFatherName,
    required this.branchMotherName,
    this.sponserId,
    required this.branchZipCode,
    this.startDate,
    required this.branchViewPassword,
    required this.categoryId,
    required this.branchKycStatus,
    required this.sponserName,
    required this.branchPhoto,
    required this.branchCv,
    required this.branchFirmName,
    required this.branchQualification,
    required this.branchDob,
    required this.branchExperience,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        cjalId: json["CJAL_ID"],
        cjalPostId: json["CJAL_POST_ID"],
        cjalLoginId: json["CJAL_LOGIN_ID"],
        cjalApplyDate: DateTime.parse(json["CJAL_APPLY_DATE"]),
        cjalStatus: json["CJAL_STATUS"],
        vapId: json["VAP_ID"],
        vapTt: DateTime.parse(json["VAP_TT"]),
        vapLoginId: json["VAP_LOGIN_ID"],
        vapTitle: json["VAP_TITLE"],
        vapDesc: json["VAP_DESC"],
        vapVideoType: json["VAP_VIDEO_TYPE"],
        vapImage: json["VAP_IMAGE"],
        vapVideoUrl: json["VAP_VIDEO_URL"],
        vapLike: json["VAP_LIKE"],
        vapComment: json["VAP_COMMENT"],
        branchId: json["BRANCH_ID"],
        firmId: json["FIRM_ID"],
        branchName: json["BRANCH_NAME"],
        branchCode: json["BRANCH_CODE"],
        branchAddress: json["BRANCH_ADDRESS"],
        branchState: json["BRANCH_STATE"],
        branchCity: json["BRANCH_CITY"],
        branchContact: json["BRANCH_CONTACT"],
        branchPhone: json["BRANCH_PHONE"],
        branchEmail: json["BRANCH_EMAIL"],
        branchTarget: json["BRANCH_TARGET"],
        branchCreated: json["BRANCH_CREATED"],
        branchTt: DateTime.parse(json["BRANCH_TT"]),
        branchUsername: json["BRANCH_USERNAME"],
        branchPassword: json["BRANCH_PASSWORD"],
        branchStatus: json["BRANCH_STATUS"],
        companyHrmType: json["COMPANY_HRM_TYPE"],
        branchFatherName: json["BRANCH_FATHER_NAME"],
        branchMotherName: json["BRANCH_MOTHER_NAME"],
        sponserId: json["SPONSER_ID"],
        branchZipCode: json["BRANCH_ZIP_CODE"],
        startDate: json["START_DATE"],
        branchViewPassword: json["BRANCH_VIEW_PASSWORD"],
        categoryId: json["CATEGORY_ID"],
        branchKycStatus: json["BRANCH_KYC_STATUS"],
        sponserName: json["SPONSER_NAME"],
        branchPhoto: json["BRANCH_PHOTO"],
        branchCv: json["BRANCH_CV"],
        branchFirmName: json["BRANCH_FIRM_NAME"],
        branchQualification: json["BRANCH_QUALIFICATION"],
        branchDob: json["BRANCH_DOB"],
        branchExperience: json["BRANCH_EXPERIENCE"],
      );

  Map<String, dynamic> toJson() => {
        "CJAL_ID": cjalId,
        "CJAL_POST_ID": cjalPostId,
        "CJAL_LOGIN_ID": cjalLoginId,
        "CJAL_APPLY_DATE":
            "${cjalApplyDate.year.toString().padLeft(4, '0')}-${cjalApplyDate.month.toString().padLeft(2, '0')}-${cjalApplyDate.day.toString().padLeft(2, '0')}",
        "CJAL_STATUS": cjalStatus,
        "VAP_ID": vapId,
        "VAP_TT": vapTt.toIso8601String(),
        "VAP_LOGIN_ID": vapLoginId,
        "VAP_TITLE": vapTitle,
        "VAP_DESC": vapDesc,
        "VAP_VIDEO_TYPE": vapVideoType,
        "VAP_IMAGE": vapImage,
        "VAP_VIDEO_URL": vapVideoUrl,
        "VAP_LIKE": vapLike,
        "VAP_COMMENT": vapComment,
        "BRANCH_ID": branchId,
        "FIRM_ID": firmId,
        "BRANCH_NAME": branchName,
        "BRANCH_CODE": branchCode,
        "BRANCH_ADDRESS": branchAddress,
        "BRANCH_STATE": branchState,
        "BRANCH_CITY": branchCity,
        "BRANCH_CONTACT": branchContact,
        "BRANCH_PHONE": branchPhone,
        "BRANCH_EMAIL": branchEmail,
        "BRANCH_TARGET": branchTarget,
        "BRANCH_CREATED": branchCreated,
        "BRANCH_TT": branchTt.toIso8601String(),
        "BRANCH_USERNAME": branchUsername,
        "BRANCH_PASSWORD": branchPassword,
        "BRANCH_STATUS": branchStatus,
        "COMPANY_HRM_TYPE": companyHrmType,
        "BRANCH_FATHER_NAME": branchFatherName,
        "BRANCH_MOTHER_NAME": branchMotherName,
        "SPONSER_ID": sponserId,
        "BRANCH_ZIP_CODE": branchZipCode,
        "START_DATE": startDate,
        "BRANCH_VIEW_PASSWORD": branchViewPassword,
        "CATEGORY_ID": categoryId,
        "BRANCH_KYC_STATUS": branchKycStatus,
        "SPONSER_NAME": sponserName,
        "BRANCH_PHOTO": branchPhoto,
        "BRANCH_CV": branchCv,
        "BRANCH_FIRM_NAME": branchFirmName,
        "BRANCH_QUALIFICATION": branchQualification,
        "BRANCH_DOB": branchDob,
        "BRANCH_EXPERIENCE": branchExperience,
      };
}
