class CategoryModel {
  late int id;
  late String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  int compareTo(CategoryModel other) {
    return name.compareTo(other.name);
  }

  //mengambil data dari server untuk di masukan ke model

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  //megirim data ke server

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
