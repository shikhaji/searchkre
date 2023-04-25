import 'dart:convert';

BusinessCategoryList businessCategoryListFromJson(String str) =>
    BusinessCategoryList.fromJson(json.decode(str));

String businessCategoryListToJson(BusinessCategoryList data) =>
    json.encode(data.toJson());

class BusinessCategoryList {
  BusinessCategoryList({
    required this.status,
    required this.message,
  });

  int status;
  List<BusinessCategoryData> message;

  factory BusinessCategoryList.fromJson(Map<String, dynamic> json) =>
      BusinessCategoryList(
        status: json["status"],
        message: List<BusinessCategoryData>.from(
            json["message"].map((x) => BusinessCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class BusinessCategoryData {
  BusinessCategoryData({
    required this.id,
    required this.brandName,
    required this.status,
    required this.date,
    required this.brandImage,
    required this.catImage,
    this.selected,
  });

  String id;
  String brandName;
  bool? selected = false;
  String status;
  String date;
  String brandImage;
  String catImage;

  factory BusinessCategoryData.fromJson(Map<String, dynamic> json) =>
      BusinessCategoryData(
        id: json["id"],
        brandName: json["brand_name"],
        status: json["status"],
        date: json["date"],
        brandImage: json["brand_image"],
        catImage: json["CAT_IMAGE"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name": brandName,
        "status": status,
        "date": date,
        "brand_image": brandImage,
        "CAT_IMAGE": catImage,
      };
}
