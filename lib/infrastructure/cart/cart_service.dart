import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/cart/cart_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/cart_model.dart';
import 'package:provider/provider.dart';

import '../../appication/wishlist/wishlist_provider.dart';

class CartService {
  ProductCartBaseModel? val;
  final dio = Dio();

  CartService() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }
  Future<void> addToCart(CartModel cartModel, BuildContext context) async {
    log("cartModel:---------$cartModel");
    log('$baseUrl$cartUrl/');
    try {
      Response response = await dio.post(
        '$baseUrl$cartUrl/',
        data: cartModel.toJson(),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added into cart')));
      }
      log(response.toString());
    } on DioError catch (err) {
      log(err.message);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getDataCart(BuildContext context) async {
    log('$baseUrl$cartUrl/?userid=$userId');
    try {
      Response response = await dio.get(
        '$baseUrl$cartUrl/?userid=$userId',
      );
      // log("response===" + response.data);
      // final data = CartModel.fromJson(jsonDecode(response.data));
      Map<String, dynamic> data = json.decode(response.data);

      val = ProductCartBaseModel.fromJson(data);
      // cartDataList.value.clear();
      // cartDataList.value.add(data);
      // cartDataList.notifyListeners();
      // log(cartDataList.value.toString());
      Provider.of<CartProvider>(context, listen: false).cartFunc(val!);
      // log(cartDataList.value[0]["cart"]["products"][0]["product"]["image"][0].toString());
    } on DioError catch (err) {
      log("getCart : ----${err.message}");
    } catch (e) {
      log("getCart error====$e");
    }
  }
}
