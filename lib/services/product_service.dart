// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamo/models/product_model.dart';

class ProductService {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  //function get product, untuk melakukan equest get pada product
  Future<List<ProductModel>> getProduct(categoryId) async {
    // var parameter = {'categories': categoryId};
    var url = Uri.parse('$baseUrl/products/?category=$categoryId');
    print(url);
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    print('products =  ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal get product!');
    }
  }
}
