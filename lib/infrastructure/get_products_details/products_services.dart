import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/presentation/widgets/loading_bar.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';

class ProductServices with ChangeNotifier {
  final dio = Dio();

  ProductServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

  Future getProducts(BuildContext context) async {
    log(baseUrl + productUrl);
    try {
      Provider.of<HomeProvider>(context, listen: false).loading(true);
      // HomeProvider().loading(true);
      Response response = await dio.get(baseUrl + productUrl);

      final getData = GetProductModel.fromJson(jsonDecode(response.data));
      productDataList.value.clear();
      productDataList.value.addAll(getData.products.reversed);
      productDataList.notifyListeners();
      Provider.of<HomeProvider>(context, listen: false).loading(false);
    } catch (e) {
      HomeProvider().loading(false);
      log("products:::::----------$e");
    }
  }
}
