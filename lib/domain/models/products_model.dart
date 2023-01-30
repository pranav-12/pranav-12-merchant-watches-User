import 'dart:convert';

ProductsModel? productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel? data) => json.encode(data!.toJson());

class ProductsModel {
  ProductsModel({
    this.products,
  });

  List<Product?>? products;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: json["products"] == null
            ? []
            : List<Product?>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x!.toJson())),
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
