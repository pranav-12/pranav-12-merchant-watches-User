import 'dart:convert';
import 'package:merchant_watches/domain/models/products_model.dart';

CartProductModel? cartProductModelFromJson(String str) => CartProductModel.fromJson(json.decode(str));
String cartProductModelToJson(CartProductModel? data) => json.encode(data!.toJson());

class CartProductModel {
    CartProductModel({
        this.cart,
    });

    Cart? cart;

    factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
        cart: Cart.fromJson(json["cart"]),
    );

    Map<String, dynamic> toJson() => {
        "cart": cart!.toJson(),
    };
}

class Cart {
    Cart({
        this.id,
        this.userid,
        this.products,
        this.totalPrice,
        this.v,
    });

    String? id;
    dynamic userid;
    List<ProductElement?>? products;
    int? totalPrice;
    int? v;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        userid: json["userid"],
        products: json["products"] == null ? [] : List<ProductElement?>.from(json["products"]!.map((x) => ProductElement.fromJson(x))),
        totalPrice: json["totalPrice"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x!.toJson())),
        "totalPrice": totalPrice,
        "__v": v,
    };
}

class ProductElement {
    ProductElement({
        this.product,
        this.qty,
        this.price,
        this.id,
    });

    Product? product;
    int? qty;
    int? price;
    String? id;

    factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: Product.fromJson(json["product"]),
        qty: json["qty"],
        price: json["price"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product!.toJson(),
        "qty": qty,
        "price": price,
        "_id": id,
    };
}

