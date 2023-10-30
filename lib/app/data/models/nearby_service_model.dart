List<NearbyServiceModel> nearbyServiceModelFromJson(dynamic str) =>
    List<NearbyServiceModel>.from((str as List<dynamic>).map((x) => NearbyServiceModel.fromJson(x)));

class NearbyServiceModel {
  int? id;
  String? servicename;
  String? name;
  String? address;
  String? number;
  String? img;
  String? imgAlt;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  int? servicecategoryId;

  NearbyServiceModel({
    this.id,
    this.servicename,
    this.name,
    this.address,
    this.number,
    this.img,
    this.imgAlt,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.servicecategoryId,
  });

  factory NearbyServiceModel.fromJson(Map<String, dynamic> json) => NearbyServiceModel(
        id: json["id"],
        servicename: json["servicename"],
        name: json["name"],
        address: json["address"],
        number: json["number"],
        img: json["img"],
        imgAlt: json["imgAlt"],
        metaTitle: json["metaTitle"],
        metaDescription: json["metaDescription"],
        metaKeywords: json["metaKeywords"],
        servicecategoryId: json["servicecategoryId"],
      );
}
