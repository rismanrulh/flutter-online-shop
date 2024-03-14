import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamo/models/category_model.dart';

class CategoryService {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<List<CategoryModel>> getCategory() async {
    var url = Uri.parse('$baseUrl/categories');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List categoryObject = jsonDecode(response.body)['data']['data'];
      List<CategoryModel> categories = [];
      for (var item in categoryObject) {
        categories.add(CategoryModel.fromJson(item));
      }
      categories.sort((a, b) => a.name.compareTo(b.name));
      return categories;
    } else {
      throw Exception('Gagal get Product');
    }
  }
}
