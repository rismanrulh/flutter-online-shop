// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/category_provider.dart';
import 'package:shamo/providers/product_by_category_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/providers/selected_provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widget/product_card.dart';
import 'package:shamo/widget/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    SelectedProvider selectedProvider = Provider.of<SelectedProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    ProductByCategory productByCategory =
        Provider.of<ProductByCategory>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, ${user.name}',
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text('@${user.username}',
                      style: subTitleTextStyle.copyWith(fontSize: 16)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      user.profilePhotoUrl,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget categories(CategoryProvider categoryProvider) {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                  children: categoryProvider.categories
                      .where((category) => category.name != "All Shoes")
                      .map((category) {
                bool isActive = selectedProvider.selectedCategory == category;
                return TextButton(
                  onPressed: () {
                    if (isActive) {
                      setState(() {
                        selectedProvider.selectCategory(null);
                      });
                    } else {
                      setState(() {
                        selectedProvider.selectCategory(category);
                        productProvider.getProducts(category.id);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: isActive
                          ? Border.all(color: transparentColor)
                          : Border.all(color: subTitleColor),
                      color: isActive ? primaryColor : transparentColor,
                    ),
                    child: Text(
                      category.name,
                      style: primaryTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                );
              }).toList()),
            ],
          ),
        ),
      );
    }

    Widget popularProductTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: const EdgeInsets.only(
          top: 14,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: productByCategory.productsByCategory
                    .map(
                      (product) => ProductCard(
                        product: product,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget newArrival() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 14),
              child: Text(
                'New Arrivals',
                style: primaryTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Column(
              children: productByCategory.productsByCategory
                  .map((product) => ProductTile(
                        product: product,
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    }

    Widget forYou() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 14),
              child: productProvider.products.isEmpty
                  ? Text(
                      'Tidak ada produk',
                      style: primaryTextStyle.copyWith(
                        fontSize: 22,
                      ),
                    )
                  : Text(
                      'For You',
                      style: primaryTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: semiBold,
                      ),
                    ),
            ),
            Column(
              children: [
                Column(
                  children: productProvider.products
                      .map((product) => ProductTile(
                            product: product,
                          ))
                      .toList(),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget getContentWidget() {
      if (selectedProvider.selectedCategory != null) {
        return forYou();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            popularProductTitle(),
            popularProducts(),
            newArrival(),
          ],
        );
      }
    }

    return ListView(
      children: [
        header(),
        categories(categoryProvider),
        getContentWidget(),
        // forYou(),
      ],
    );
  }
}
