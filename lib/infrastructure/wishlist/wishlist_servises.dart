import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/wishlist_model.dart';
import 'package:provider/provider.dart';

import '../../appication/wishlist/wishlist_provider.dart';

class WishListServices with ChangeNotifier {
  // WishListModel? data;

  // List<WishListModel> dataList = [];
  final dio = Dio();
  WishListServices() {
    dio.options =
        BaseOptions(baseUrl: baseUrl, responseType: ResponseType.plain);
  }

  Future<Response?> addOrRemoveWishList(String productId) async {
    log(productId.toString());
    try {
      Response response = await dio.post('$baseUrl$wishUrl/',
          data: {"userId": userId, "product": productId});

      log(response.toString());
      return response;
    } on DioError catch (err) {
      log(err.response.toString());
      return err.response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> getWishListData(BuildContext context) async {
    log('$baseUrl$wishUrl/?userId=$userId');
    try {
      Response response = await dio.get('$baseUrl$wishUrl/?userId=$userId');
      Map<String, dynamic> data = await json.decode(response.data);
      // data = WishListModel.fromJson(map);
      wishDataList.value.clear();
      wishDataList.value
          .addAll(WishListModel.fromJson(data).products!.reversed);
      wishDataList.notifyListeners();
      log(wishDataList.value.toString());
      // for (var i = 0; i < data!.products!.length; i++) {
      //   if (data!.products![i]!.product!.category == "Smart Watches") {
      //     log(data!.products![i].toString());
      //   }
      // }
      // log(data!.products![0]!.product!.category.toString());
      // Provider.of<WishListProvider>(context, listen: false).assignData(data!);
    } on DioError catch (err) {
      log(err.message);
    } catch (e) {
      log("eeee--------------$e");
    }
  }
}
