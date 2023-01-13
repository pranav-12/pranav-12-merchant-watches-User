import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/cart_model.dart';

class CartService {
  final dio = Dio();

  CartService() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }
  Future<void> addToCart(CartModel cartModel) async {
    log("cartModel:---------$cartModel");
    log('$baseUrl$cartUrl/');
    try {
      Response response = await dio.post(
        '$baseUrl$cartUrl/',
        data: cartModel.toJson(),
      );

      log(response.toString());
    } on DioError catch (err) {
      log(err.message);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getDataCart() async {
    log('getting........');
    try {
      Response response = await dio.get(
        '$baseUrl$cartUrl/?userid=$userId',
      );
      // log("response===" + response.data);
      // final data = CartModel.fromJson(jsonDecode(response.data));
      Map<String, dynamic> data = jsonDecode(response.data);
      cartDataList.value.clear();
      cartDataList.value.add(data);
      cartDataList.notifyListeners();
      log(cartDataList.value.toString());
      // log(cartDataList.value[0]["cart"]["products"][0]["product"]["image"][0].toString());
    } on DioError catch (err) {
      log("getCart : ----${err.message}");
    } catch (e) {
      log("getCart error====$e");
    }
  }
}
