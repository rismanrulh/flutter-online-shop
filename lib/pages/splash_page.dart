// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/category_provider.dart';
import 'package:shamo/providers/product_by_category_provider.dart';
import 'package:shamo/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    gitInit();
    super.initState();
  }

  gitInit() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategories(); //productByCategory
    // ignore: use_build_context_synchronously
    await Provider.of<ProductByCategory>(context, listen: false)
        .getProductsByCategory(); //allProduct

    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
