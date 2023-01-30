import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';

class ProductServices with ChangeNotifier {
  final dio = Dio();

 ProductServices.internal();
  static ProductServices instance = ProductServices.internal();

  ProductServices factory() {
    return instance;
  }
  ProductServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

// For Get Products Details From Api's
  Future getProducts(context) async {
    try {
      Provider.of<HomeProvider>(context, listen: false).loading(true);
      Response response = await dio.get(baseUrl + productUrl);
      Map<String, dynamic> product = json.decode(response.data);
      final getData = ProductsModel.fromJson(product);
      productDataList.value.clear();
      productDataList.value.addAll(getData.products!.reversed);
      productDataList.notifyListeners();
      log(productDataList.value.toString());
      Provider.of<HomeProvider>(context, listen: false).loading(false);
    } catch (e) {
      Provider.of<HomeProvider>(context, listen: false).loading(true);
      HomeProvider().loading(false);
      log("products:::::----------$e");
    }
  }
}
