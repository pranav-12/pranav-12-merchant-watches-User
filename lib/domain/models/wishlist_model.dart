// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

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
  List<ProductElement?>? products;
  int? v;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        id: json["_id"],
        userId: json["userId"],
        products: json["products"] == null
            ? []
            : List<ProductElement?>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
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

class ProductElement {
  ProductElement({
    this.product,
    this.id,
  });

  ProductProduct? product;
  String? id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product!.toJson(),
        "_id": id,
      };
}

class ProductProduct {
  ProductProduct({
    this.id,
    this.name,
    this.price,
    this.description,
    this.image,
    this.category,
    this.deliveryFee,
    this.v,
  });

  String? id;
  String? name;
  int? price;
  String? description;
  List<String?>? image;
  String? category;
  String? deliveryFee;
  int? v;

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        image: json["image"] == null
            ? []
            : List<String?>.from(json["image"]!.map((x) => x)),
        category: json["category"],
        deliveryFee: json["deliveryFee"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "category": category,
        "deliveryFee": deliveryFee,
        "__v": v,
      };
}
