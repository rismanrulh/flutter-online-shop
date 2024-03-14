// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/services/category_servise.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  set categories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      List<CategoryModel> categories = await CategoryService().getCategory();
      _categories = categories;
    } catch (e) {
      print(e);
    }
  }
}
