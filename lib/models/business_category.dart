class BusinessCategory {
  BusinessCategory({
    this.id,
    this.vendorId,
    this.brandName,
    this.status,
    this.date,
    this.brandImage,
    this.catImage,
  });

  String? id;
  String? vendorId;
  String? brandName;
  String? status;
  String? date;
  String? brandImage;
  String? catImage;

  factory BusinessCategory.fromJson(Map<String, dynamic> json) =>
      BusinessCategory(
        id: json["id"],
        vendorId: json["vendor_id"],
        brandName: json["brand_name"],
        status: json["status"],
        date: json["date"],
        brandImage: json["brand_image"],
        catImage: json["CAT_IMAGE"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "brand_name": brandName,
        "status": status,
        "date": date,
        "brand_image": brandImage,
        "CAT_IMAGE": catImage,
      };
}
