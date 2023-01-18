// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/infrastructure/wishlist/wishlist_servises.dart';

import '../../domain/models/products_model.dart';

class HomeProvider with ChangeNotifier {
  List addToCartList = [];

  bool visible = true;
  // List<bool> wishListClicked = [false];

  bool loadingBool = false;

  void loading(bool val) {
    loadingBool = val;

    log("val---------------" + val.toString());
    log("loading----------------" + loadingBool.toString());
    notifyListeners();
  }

  void visibleONOrOf(bool val) {
    visible = val;
    notifyListeners();
  }

  void addToCart(Product product, BuildContext context) async {
    try {
      Response? response = await CartService().addToCart(product, context, 1);

      await CartService().getDataCart(context);
      log('ggg');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            backgroundColor:
                response!.statusCode == 201 ? Colors.green : Colors.red,
            content:
                //  response.statusCode == 201
                const Text("Product Added to Cart")),
      );
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void addOrRemoveWishListFucn(String productId, BuildContext context) async {
    try {
      Response response =
          await WishListServices().addOrRemoveWishList(productId) as Response;

      await WishListServices().getWishListData(context);
      log('ggg');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            backgroundColor:
                response.statusCode == 201 ? Colors.green : Colors.red,
            content: response.statusCode == 201
                //  response.statusCode == 201
                ? const Text("Product Added to wishList")
                : const Text("Product Removed From wishList")),
      );
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void addUserId(String id) {
    userId = id;
    log('userIDProvider========$userId');
    notifyListeners();
  }
}
