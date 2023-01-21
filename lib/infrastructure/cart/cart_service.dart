import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/cart/cart_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/cart_model.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:provider/provider.dart';

import '../../appication/wishlist/wishlist_provider.dart';

class CartService with ChangeNotifier {
  final dio = Dio();

  CartService() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }
  Future<Response?> addToCart(
      Product product, BuildContext context, int qty) async {
    log("cartModelproductId:---------$product");
    log('$cartUrl/');
    try {
      Response response = await dio.post(
        '$cartUrl/',
        data: {"userid": userId, "product": product.id, "qty": qty},
      );
      log(response.toString());
      return response;
    } on DioError catch (err) {
      log(err.message);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> removeFromCart(Product product) async {
    try {
      Response response = await dio.patch('$cartUrl/',
          data: {"userid": userId, "product": product.id});

      log(response.data);
    } catch (e) {
      log(e.toString());
    }
  }

// int totalAmount = 0;
  Future<Response?> getDataCart(BuildContext context) async {
    log('$cartUrl/?userid=$userId');
    try {
      Response response = await dio.get(
        '$cartUrl/?userid=$userId',
      );
      // log("response===" + response.data);
      // final data = CartModel.fromJson(jsonDecode(response.data));
      
      Map<String, dynamic> data = json.decode(response.data);

      final val = CartProductModel.fromJson(data);
      log(val.toString());
      cartDataList.value.clear();
      totalPrice.value = val.cart!.totalPrice!;
      cartDataList.value.addAll(val.cart!.products!.reversed);
      cartDataList.notifyListeners();
      totalPrice.notifyListeners();
      Provider.of<CartProvider>(context, listen: false).totalQuantity();
      log(cartDataList.value.toString());
      log("₹₹₹₹₹₹₹₹₹₹₹₹₹₹₹₹₹₹${totalPrice.value}");
      return response;
      // log(cartDataList.value.toString());
      // Provider.of<CartProvider>(context, listen: false).cartFunc(val!);
      // log(cartDataList.value[0]["cart"]["products"][0]["product"]["image"][0].toString());
    } on DioError catch (err) {
      log("getCart : ----${err.message}");
      return err.response;
    } catch (e) {
      log("getCart error====$e");
    }
    return null;
  }
}
