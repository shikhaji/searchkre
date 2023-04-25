import 'dart:convert';

PostDetailsModel postDetailsModelFromJson(String str) =>
    PostDetailsModel.fromJson(json.decode(str));

String postDetailsModelToJson(PostDetailsModel data) =>
    json.encode(data.toJson());

class PostDetailsModel {
  PostDetailsModel({
    required this.status,
    required this.message,
  });

  int status;
  PostDetailsData message;

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) =>
      PostDetailsModel(
        status: json["status"],
        message: PostDetailsData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class PostDetailsData {
  PostDetailsData({
    required this.post,
  });

  List<Post> post;

  factory PostDetailsData.fromJson(Map<String, dynamic> json) =>
      PostDetailsData(
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
