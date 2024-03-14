// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shamo/services/product_service.dart';
// import 'dart:developer';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  //getter & setter
  List<ProductModel> get products => _products;

  set product(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

//function untuk get productsnya
  Future getProducts(int categoryId) async {
    try {
      List<ProductModel> products =
          await ProductService().getProduct(categoryId);
      _products = products;
      print('products by category : $products');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  setProducts(List<ProductModel> products) {
    _products = products;
    print('setProducts : $products');
    notifyListeners();
  }
}
