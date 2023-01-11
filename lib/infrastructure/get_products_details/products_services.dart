import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import '../../constants/constants.dart';

class ProductServices {
  final dio = Dio();

  ProductServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

  Future getProducts() async {
    try {
      Response response = await dio.get(baseUrl + productUrl);

      final getData = GetProductModel.fromJson(jsonDecode(response.data));

      productDataList.value.clear();
      productDataList.value.addAll(getData.products.reversed);
      productDataList.notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
