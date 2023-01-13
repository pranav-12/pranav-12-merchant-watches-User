import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/domain/models/user_model.dart';

class ProductCartBaseModel {
  List<dynamic> cart;
  ProductCartBaseModel({this.cart = const []});
  factory ProductCartBaseModel.fromJson(Map<String, dynamic> json) =>
      ProductCartBaseModel(cart: json["cart"]);
}

class CartModel {
  String? id;
  String? userId;
  String? productDatasId;
  int? qty;

  CartModel({this.userId, this.productDatasId, this.qty, this.id});

  CartModel.create({
    required this.userId,
    required this.productDatasId,
    required this.qty,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["_id"],
      userId: json["userid"],
      productDatasId: json["product"],
      qty: json["qty"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userId,
        "product": productDatasId,
        "qty": qty,
      };
}
