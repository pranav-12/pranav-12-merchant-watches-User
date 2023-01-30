import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';

import '../../domain/models/cart_model.dart';
import '../../domain/models/products_model.dart';
import '../../domain/models/wishlist_model.dart';

class HomeProvider with ChangeNotifier {
  List addToCartList = [];
  bool loadingBool = false;

// For CircularLoading Bar
  void loading(bool val) {
    loadingBool = val;
    notifyListeners();
  }

// For Storing UserId
  void addUserId(String id) {
    userId = id;
    notifyListeners();
  }


// For Searchid From Wishlist and Cart
  bool searchIDForWishList(
      {required Product product,
      required bool isWishList,
      List<ProductElementForWishList?>? wisList,
      List<ProductElement?>? cartElement}) {
    bool findProductId = false;
    if (isWishList == true) {
      for (var i = 0; i < wisList!.length; i++) {
        if (wisList[i]!.product!.id == product.id) {
          return findProductId = true;
        }
      }
    } else {
      log('entry');
      for (var i = 0; i < cartElement!.length; i++) {
        log('---------------message');
        if (cartElement[i]!.product!.id == product.id) {
          return findProductId = true;
        }
      }
      log("FIND__________________________ID$findProductId");
    }

    return findProductId;
  }
}
