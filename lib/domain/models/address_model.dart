// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel?>? addressModelFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<AddressModel?>.from(
            json.decode(str)!.map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

    class AddressModel {
    AddressModel({
        this.address,
    });

    List<Address?>? address;

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        address: json["address"] == null ? [] : List<Address?>.from(json["address"]!.map((x) => Address.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x!.toJson())),
    };
}


class Address {
  Address({
    this.id,
    this.userId,
    this.fullName,
    this.phone,
    this.pin,
    this.state,
    this.place,
    this.address,
  });

  String? id;
  String? userId;
  String? fullName;
  String? phone;
  String? pin;
  String? state;
  String? place;
  String? address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        userId: json["user"],
        fullName: json["fullName"],
        phone: json["phone"],
        pin: json["pin"],
        state: json["state"],
        place: json["place"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "fullName": fullName,
        "phone": phone,
        "pin": pin,
        "state": state,
        "place": place,
        "address": address,
      };
}
