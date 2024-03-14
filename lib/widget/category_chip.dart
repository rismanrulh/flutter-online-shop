import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/providers/selected_provider.dart';
import 'package:shamo/theme.dart';

class CategoryChip extends StatefulWidget {
  const CategoryChip({super.key, required this.category});
  final CategoryModel category;

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  @override
  Widget build(BuildContext context) {
    SelectedProvider selectedProvider = Provider.of<SelectedProvider>(context);
    bool isActive = selectedProvider.selectedCategory == widget.category;

    return GestureDetector(
      onTap: () {
        selectedProvider.selectCategory(widget.category);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          border: isActive
              ? Border.all(color: transparentColor)
              : Border.all(color: subTitleColor),
          borderRadius: BorderRadius.circular(12),
          color: isActive ? primaryColor : transparentColor,
        ),
        child: Text(
          widget.category.name,
          style: primaryTextStyle.copyWith(
            fontSize: 13,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
