import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/wishlist/wishlist_servises.dart';

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

  void addOrRemoveCartFucn(bool click, int index, BuildContext context) {


   
    // if (click == true) {
    //   // wishDataList.value.remove(productDataList.value[index]);
    //   WishListServices()
    //       .addOrRemoveWishList(productDataList.value[index]["_id"]);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         behavior: SnackBarBehavior.floating,
    //         duration: Duration(seconds: 1),
    //         content: const Text("Product removed Form wishList")),
    //   );
    //   notifyListeners();
    // } else {
    //   // wishDataList.value.add(productDataList.value[index]);
    //   WishListServices()
    //       .addOrRemoveWishList(productDataList.value[index]["_id"]);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.floating,
    //       duration: Duration(seconds: 1),
    //       content: const Text("Product added To wishList"),
    //     ),
    //   );
    //   notifyListeners();
    // }
    // WishListServices().addOrRemoveWishList(productDataList.value[index]["_id"]);
  }

  void addUserId(String id) {
    userId = id;
    log('userIDProvider========$userId');
    notifyListeners();
  }
}
