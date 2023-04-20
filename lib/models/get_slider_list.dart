import 'dart:convert';

SliderModel sliderListFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderListToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    required this.status,
    required this.message,
  });

  int status;
  List<SliderData> message;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        status: json["status"],
        message: List<SliderData>.from(
            json["message"].map((x) => SliderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class SliderData {
  SliderData({
    required this.id,
    required this.sliderImage,
    required this.title,
  });

  String id;
  String sliderImage;
  String title;

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
        id: json["id"],
        sliderImage: json["slider_image"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slider_image": sliderImage,
        "title": title,
      };
}
