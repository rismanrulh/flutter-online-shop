import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/providers/whislist_provider.dart';
import 'package:shamo/theme.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    WhistlistProvider wishtlistProvider =
        Provider.of<WhistlistProvider>(context);
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.galleries[0].url,
              width: 60,
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
                  product.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishtlistProvider.setProduct(product);
            },
            child: Image.asset(
              'assets/button_wishlist_active.png',
              width: 34,
            ),
          )
        ],
      ),
    );
  }
}
