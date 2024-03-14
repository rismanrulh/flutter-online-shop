import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/product_page.dart';
import 'package:shamo/providers/selected_provider.dart';
import 'package:shamo/theme.dart';

import '../models/product_model.dart';

class ProductTileByCategory extends StatelessWidget {
  const ProductTileByCategory({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final SelectedProvider selectedProvider =
        Provider.of<SelectedProvider>(context);
    final selectedCategory = selectedProvider.selectedCategory;
    if (selectedCategory != null && product.category == selectedCategory) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProdcutPage(product: product),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            bottom: defaultMargin,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.galleries[0].url,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.name,
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      product.name,
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '\$${product.price}',
                      style: priceTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
