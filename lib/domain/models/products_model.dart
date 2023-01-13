class GetProductModel {
  List<dynamic> products;

  GetProductModel({this.products = const []});

  factory GetProductModel.fromJson(Map<String, dynamic> json) {
    return GetProductModel(products: json["products"]);
  }

  Map<String, dynamic> toJson() => {
        "products": products,
      };
}

class ProductDatas {
  String? id;
  String? name;
  int? price;
  String? description;
  List<String>? image;
  String? category;
  String? deliveryFee;

  ProductDatas.create({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.deliveryFee,
  });

  ProductDatas({
    this.id,
    this.name,
    this.price,
    this.description,
    this.image,
    this.category,
    this.deliveryFee,
  });

  factory ProductDatas.fromJson(Map<String, dynamic> json) {
    return ProductDatas(
      id: json["_id"],
      name: json["name"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      category: json["category"],
      deliveryFee: json["deliveryFee"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "category": category,
        "deliveryFee": deliveryFee,
      };
}
