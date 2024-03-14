import 'package:shamo/models/product_model.dart';

class CartModel {
  late int id;
  late ProductModel product;
  late int quantity;

  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  double getTotalPrice() {
    return product.price * quantity;
  }
}
