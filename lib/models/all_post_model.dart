import 'dart:convert';

AllPostModel allPostModelFromJson(String str) =>
    AllPostModel.fromJson(json.decode(str));

String allPostModelToJson(AllPostModel data) => json.encode(data.toJson());

class AllPostModel {
  AllPostModel({
    required this.status,
    required this.message,
  });

  int status;
  AllPostList message;

  factory AllPostModel.fromJson(Map<String, dynamic> json) => AllPostModel(
        status: json["status"],
        message: AllPostList.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class AllPostList {
  AllPostList({
    required this.allPost,
  });

  List<AllPost> allPost;

  factory AllPostList.fromJson(Map<String, dynamic> json) => AllPostList(
        allPost: List<AllPost>.from(
            json["all_post"].map((x) => AllPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_post": List<dynamic>.from(allPost.map((x) => x.toJson())),
      };
}

class AllPost {
  AllPost({
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

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
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
