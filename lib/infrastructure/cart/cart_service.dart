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

class CartService with ChangeNotifier {
  final dio = Dio();

  CartService() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

  // For Adding Carts To BackEnd
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

// For Remove Carts To BackEnd
  Future<void> removeFromCart(Product product) async {
    try {
      Response response = await dio
          .patch('$cartUrl/', data: {"userid": userId, "product": product.id});
      log(response.data);
    } catch (e) {
      log(e.toString());
    }
  }

// For Get Carts From Api's
  Future<Object?> getDataCart(context) async {
    log('$cartUrl/?userid=$userId');
    try {
      Response response = await dio.get(
        '$cartUrl/?userid=$userId',
      );
      Map<String, dynamic> data = await json.decode(response.data ?? []);
      final val = CartProductModel.fromJson(data);
      cartDataList.value.clear();
      totalPrice.value = val.cart!.totalPrice!;
      cartDataList.value.addAll(val.cart!.products!.reversed);
      cartDataList.notifyListeners();
      totalPrice.notifyListeners();
      Provider.of<CartProvider>(context, listen: false).totalQuantity();
      return response;
    } on DioError catch (err) {
      log("getCart : ----${err.message}");
      return err.response;
    } catch (e) {
      log("getCart error====$e");
      cartDataList.value.clear();
      cartDataList.notifyListeners();
      return [];
    }
  }
}
