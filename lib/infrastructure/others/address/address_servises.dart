import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/address_model.dart';

class AddressServices with ChangeNotifier{
  final dio = Dio();

  AddressServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

// For Add Address To BackEnd
  Future<Response?> addAddress(Address addressModel) async {
    try {
      Response response =
          await dio.post("$addressUrl/", data: addressModel.toJson());

      log(response.toString());
      return response;
    } on DioError catch (err) {
      log(err.response.toString());
      return err.response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

// For Get All Address Datas From Api's
  Future<Response?> getAllAddress() async {
    try {
      Response response = await dio.get(
        "$addressUrl/?userId=$userId",
      );
      Map<String, dynamic> data = jsonDecode(response.data);
      final address = AddressModel.fromJson(data);
      addressDataList.value.clear();
      addressDataList.value.addAll(address.address!.reversed);
      addressDataList.notifyListeners();
      log(addressDataList.value.toString());
      log(response.toString());
      return response;
    } on DioError catch (err) {
      log(err.response.toString());
      return err.response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

// For Update Address  To BackEnd
  Future<Response?> upDateAddress(Address address) async {
    try {
      Response response =
          await dio.patch("$addressUrl/", data: address.toJson());
      log("updateAddress$response");
      return response;
    } on DioError catch (err) {
      log("dio errror :----------${err.response}");
      return err.response;
    } catch (e) {
      log("e:-------$e");
    }
    return null;
  }

// For Delete Address To BackEnd
  Future<Response?> deleteAddress(Address address) async {
    try {
      Response response = await dio.delete("$addressUrl/${address.id}");
      log(response.toString());
      return response;
    } on DioError catch (err) {
      log(err.response.toString());
      return err.response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

// Find the Id For Get Address For Edit
  Address? getNoteByID(String id) {
    try {
      return addressDataList.value.firstWhere((address) => address!.id == id);
    } catch (_) {
      return null;
    }
  }
}
