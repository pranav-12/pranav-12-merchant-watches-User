import 'cart_model.dart';

class OrderModel {
  OrderModel({
    this.id,
    this.products,
    this.paymentType,
    this.paymentStatus,
    this.orderStatus,
    this.fullName,
    this.phone,
    this.pin,
    this.state,
    this.place,
    this.addressId,
    this.userid,
    this.address,
    this.orderDate,
    this.deliveryDate,
    this.cancelDate,
    this.totalPrice,
  });

  String? id;
  List<ProductElement?>? products;
  String? paymentType;
  bool? paymentStatus;
  String? orderStatus;
  String? fullName;
  String? phone;
  String? pin;
  String? state;
  String? place;
  String? address;
  DateTime? orderDate;
  String? userid;
  String? addressId;
  DateTime? deliveryDate;
  dynamic cancelDate;
  int? totalPrice;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        products: json["products"] == null
            ? []
            : List<ProductElement>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
        paymentType: json["paymentType"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        fullName: json["fullName"],
        phone: json["phone"],
        pin: json["pin"],
        addressId: json["addressId"],
        userid: json["userid"],
        state: json["state"],
        place: json["place"],
        address: json["address"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        deliveryDate: json["deliveryDate"] == null
            ? null
            : DateTime.parse(json["deliveryDate"]),
        cancelDate: json["cancelDate"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x!.toJson())),
        "paymentType": paymentType,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "fullName": fullName,
        "phone": phone,
        "pin": pin,
        "state": state,
        "userid": userid,
        "addressId": addressId,
        "place": place,
        "address": address,
        "orderDate": orderDate?.toIso8601String(),
        "deliveryDate": deliveryDate?.toIso8601String(),
        "cancelDate": cancelDate,
        "totalPrice": totalPrice,
      };
}
