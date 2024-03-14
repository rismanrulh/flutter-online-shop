import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/gallery_model.dart';

class ProductModel {
  late int id;
  late String name;
  late double price;
  late String description;
  late String tags;
  late CategoryModel category;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<GalleryModel> galleries;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.galleries,
  });

  ProductModel.empty();

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //jaga jaga apabila tipe data nya bukan double
    price = double.parse(json['price'].toString());
    description = json['description'];
    tags = json['tags'] ?? '';
    category = CategoryModel.fromJson(json['category']);
    galleries = json['galleries']
        .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  //function to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'galleries': galleries.map((gallery) => gallery.toJson()).toList(),
      'category': category.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

class UninitializedProductModel extends ProductModel {
  UninitializedProductModel() : super.empty();
}
