import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    required this.status,
    required this.message,
  });

  int status;
  FaqData message;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    status: json["status"],
    message: FaqData.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message.toJson(),
  };
}

class FaqData {
  FaqData({
    required this.fquestion,
  });

  List<Fquestion> fquestion;

  factory FaqData.fromJson(Map<String, dynamic> json) => FaqData(
    fquestion: List<Fquestion>.from(json["fquestion"].map((x) => Fquestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fquestion": List<dynamic>.from(fquestion.map((x) => x.toJson())),
  };
}

class Fquestion {
  Fquestion({
    required this.fquestionId,
    required this.fquestionTt,
    required this.fquestion,
    required this.fanswer,
    required this.fstatus,
  });

  String fquestionId;
  DateTime fquestionTt;
  String fquestion;
  String fanswer;
  String fstatus;

  factory Fquestion.fromJson(Map<String, dynamic> json) => Fquestion(
    fquestionId: json["FQUESTION_ID"],
    fquestionTt: DateTime.parse(json["FQUESTION_TT"]),
    fquestion: json["FQUESTION"],
    fanswer: json["FANSWER"],
    fstatus: json["FSTATUS"],
  );

  Map<String, dynamic> toJson() => {
    "FQUESTION_ID": fquestionId,
    "FQUESTION_TT": fquestionTt.toIso8601String(),
    "FQUESTION": fquestion,
    "FANSWER": fanswer,
    "FSTATUS": fstatus,
  };
}
