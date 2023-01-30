import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../domain/models/wishlist_model.dart';
import '../../infrastructure/wishlist/wishlist_servises.dart';

class WishListProvider with ChangeNotifier {
  WishListModel? data;

// For Assigning the given Data to Data
  void assignData(WishListModel val) {
    data = val;
    notifyListeners();
  }

// this Function for AddOrRemove WishList
  void addOrRemoveWishListFucn(String productId, BuildContext context) async {
    try {
      Response response =
          await WishListServices().addOrRemoveWishList(productId) as Response;
      await WishListServices().getWishListData(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
}
