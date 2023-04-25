import 'dart:convert';

AllCompanyPostJobModel allCompanyPostJobModelFromJson(String str) =>
    AllCompanyPostJobModel.fromJson(json.decode(str));

String allCompanyPostJobModelToJson(AllCompanyPostJobModel data) =>
    json.encode(data.toJson());

class AllCompanyPostJobModel {
  AllCompanyPostJobModel({
    required this.status,
    required this.message,
  });

  int status;
  CompanyPostData message;

  factory AllCompanyPostJobModel.fromJson(Map<String, dynamic> json) =>
      AllCompanyPostJobModel(
        status: json["status"],
        message: CompanyPostData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class CompanyPostData {
  CompanyPostData({
    required this.post,
  });

  List<Post> post;

  factory CompanyPostData.fromJson(Map<String, dynamic> json) =>
      CompanyPostData(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "post": List<dynamic>.from(post.map((x) => x.toJson())),
      };
}

class Post {
  Post({
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
  });

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

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
