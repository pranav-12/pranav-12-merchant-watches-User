import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/wishlist_model.dart';

class WishListServices with ChangeNotifier {
  final dio = Dio();
  WishListServices() {
    dio.options =
        BaseOptions(baseUrl: baseUrl, responseType: ResponseType.plain);
  }

// For Add And Remove the Data's From WishList
  Future<Response?> addOrRemoveWishList(String productId) async {
    log(productId.toString());
    try {
      Response response = await dio
          .post('$wishUrl/', data: {"userId": userId, "product": productId});
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

// For Get WishListData's From Api's
  Future<void> getWishListData(BuildContext context) async {
    try {
      Response response = await dio.get('$wishUrl/?userId=$userId');
      log("*********--------**************----${response.data}");
      Map<String, dynamic> data = await json.decode(response.data);
      // data = WishListModel.fromJson(map);
      wishDataList.value.clear();
      wishDataList.value
          .addAll(WishListModel.fromJson(data).products!.reversed);
      wishDataList.notifyListeners();
      log("wishList__________________${wishDataList.value}");
    } on DioError catch (err) {
      log(err.message);
    } catch (e) {
      log("eeee--------------$e");
    }
  }
}
