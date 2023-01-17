// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

import 'package:merchant_watches/domain/models/products_model.dart';

WishListModel? wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel? data) => json.encode(data!.toJson());

class WishListModel {
  WishListModel({
    this.id,
    this.userId,
    this.products,
    this.v,
  });

  String? id;
  String? userId;
  List<ProductElementForWishList?>? products;
  int? v;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        id: json["_id"],
        userId: json["userId"],
        products: json["products"] == null
            ? []
            : List<ProductElementForWishList?>.from(
                json["products"]!.map((x) => ProductElementForWishList.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x!.toJson())),
        "__v": v,
      };
}

class ProductElementForWishList {
  ProductElementForWishList({
    this.product,
    this.id,
  });

  Product? product;
  String? id;

  factory ProductElementForWishList.fromJson(Map<String, dynamic> json) => ProductElementForWishList(
        product: Product.fromJson(json["product"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product!.toJson(),
        "_id": id,
      };
}
