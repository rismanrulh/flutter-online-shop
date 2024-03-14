class UserModel {
  late int id;
  late String name;
  late String email;
  late String username;
  late String profilePhotoUrl;
  late String token;

//konstruktor, yg dimasukan parameter nanti langusng ke simpan ke dalam this.id

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.profilePhotoUrl,
    required this.token,
  });
//Map data yang memili key dan value => key : value
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'] ?? "";
    token = json['token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
