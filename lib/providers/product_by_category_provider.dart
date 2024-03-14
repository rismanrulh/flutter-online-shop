// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/services/product_by_category_service.dart';

class ProductByCategory with ChangeNotifier {
  List<ProductModel> _productsByCategory = [];

  List<ProductModel> get productsByCategory => _productsByCategory;

  set productByCategory(List<ProductModel> productByCategory) {
    _productsByCategory = productByCategory;
    notifyListeners();
  }

  Future getProductsByCategory() async {
    try {
      List<ProductModel> productsByCategory =
          await ProductByCategoryService().getProductsByCategory();
      _productsByCategory = productsByCategory;
    } catch (e) {
      print(e);
    }
  }
}
