

List<CategoryModel> categoryModelFromJson(dynamic str) => List<CategoryModel>.from((str as List<dynamic>).map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  int? id;
  String ?name;
  String ?imgUrl;

  CategoryModel({
    this.id,
    this.name,
    this.imgUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    imgUrl: json["imgUrl"],
  );

}
