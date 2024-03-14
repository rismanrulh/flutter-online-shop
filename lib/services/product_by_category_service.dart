// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamo/models/product_model.dart';

class ProductByCategoryService {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';
  //function get product, untuk melakukan equest get pada product
  Future<List<ProductModel>> getProductsByCategory() async {
    // Map<String, dynamic> parameter = {'categories': id};
    var url = Uri.parse('$baseUrl/products');
    print(url);
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    print('productByCategory = ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal get product berdasarkan kategori!');
    }
  }
}
