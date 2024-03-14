import 'package:flutter/material.dart';
import 'package:shamo/models/category_model.dart';

class SelectedProvider extends ChangeNotifier {
  CategoryModel? _selectedCategory;

  CategoryModel? get selectedCategory => _selectedCategory;

  void selectCategory(CategoryModel? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
