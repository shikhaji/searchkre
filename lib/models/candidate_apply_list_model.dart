import 'dart:convert';

CandidateApplyListModel candidateApplyListModelFromJson(String str) =>
    CandidateApplyListModel.fromJson(json.decode(str));

String candidateApplyListModelToJson(CandidateApplyListModel data) =>
    json.encode(data.toJson());

class CandidateApplyListModel {
  CandidateApplyListModel({
    required this.status,
    required this.message,
  });

  int status;
  CandidateApplyList message;

  factory CandidateApplyListModel.fromJson(Map<String, dynamic> json) =>
      CandidateApplyListModel(
        status: json["status"],
        message: CandidateApplyList.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class CandidateApplyList {
  CandidateApplyList({
    required this.job,
  });

  List<Job> job;

  factory CandidateApplyList.fromJson(Map<String, dynamic> json) =>
      CandidateApplyList(
        job: List<Job>.from(json["job"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "job": List<dynamic>.from(job.map((x) => x.toJson())),
      };
}

class Job {
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
    required this.vapLike,
    required this.vapComment,
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchState,
    required this.branchCity,
    required this.branchContact,
    required this.branchPassword,
    required this.branchStatus,
    required this.companyHrmType,
    required this.branchFatherName,
    required this.branchMotherName,
    required this.branchZipCode,
    required this.branchViewPassword,
    required this.branchQualification,
    required this.branchDob,
    required this.branchExperience,
  });

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
  String vapLike;
  String vapComment;
  String branchId;
  String branchName;
  String branchAddress;
  String branchState;
  String branchCity;
  String branchContact;
  String branchPassword;
  String branchStatus;
  String companyHrmType;
  String branchFatherName;
  String branchMotherName;
  String branchZipCode;
  String branchViewPassword;
  String branchQualification;
  String branchDob;
  String branchExperience;

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
        vapLike: json["VAP_LIKE"],
        vapComment: json["VAP_COMMENT"],
        branchId: json["BRANCH_ID"],
        branchName: json["BRANCH_NAME"],
        branchAddress: json["BRANCH_ADDRESS"],
        branchState: json["BRANCH_STATE"],
        branchCity: json["BRANCH_CITY"],
        branchContact: json["BRANCH_CONTACT"],
        branchPassword: json["BRANCH_PASSWORD"],
        branchStatus: json["BRANCH_STATUS"],
        companyHrmType: json["COMPANY_HRM_TYPE"],
        branchFatherName: json["BRANCH_FATHER_NAME"],
        branchMotherName: json["BRANCH_MOTHER_NAME"],
        branchZipCode: json["BRANCH_ZIP_CODE"],
        branchViewPassword: json["BRANCH_VIEW_PASSWORD"],
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
        "VAP_LIKE": vapLike,
        "VAP_COMMENT": vapComment,
        "BRANCH_ID": branchId,
        "BRANCH_NAME": branchName,
        "BRANCH_ADDRESS": branchAddress,
        "BRANCH_STATE": branchState,
        "BRANCH_CITY": branchCity,
        "BRANCH_CONTACT": branchContact,
        "BRANCH_PASSWORD": branchPassword,
        "BRANCH_STATUS": branchStatus,
        "COMPANY_HRM_TYPE": companyHrmType,
        "BRANCH_FATHER_NAME": branchFatherName,
        "BRANCH_MOTHER_NAME": branchMotherName,
        "BRANCH_ZIP_CODE": branchZipCode,
        "BRANCH_VIEW_PASSWORD": branchViewPassword,
        "BRANCH_QUALIFICATION": branchQualification,
        "BRANCH_DOB": branchDob,
        "BRANCH_EXPERIENCE": branchExperience,
      };
}
