import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/appication/other/orders/orders_provider.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/cart_model.dart';

class OrderServices {
  final dio = Dio();

  OrderServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

  Future<Response?> createOrder(Order order) async {
    log(order.toJson().toString());
    try {
      Response response = await dio.post("$orderUrl/", data: order.toJson());

      // Map<String, dynamic> data = json.decode(response.data);

      // final orders = OrderModel.fromJson(data);
      log("RES:-----------" + response.data);
      return response;
    } on DioError catch (err) {
      log(err.message);
      return err.response;
    } catch (e) {
      log("createOrder catch :________$e");
    }

    return null;
  }

  Future<Response?> getOrders(BuildContext context) async {
    Provider.of<OrderProvider>(context, listen: false).order.clear();
    try {
      Response response = await dio.get("$orderUrl/");
      Map<String, dynamic> data = await json.decode(response.data);
      final orders = OrderModel.fromJson(data);
      Provider.of<OrderProvider>(context, listen: false).orders = orders;
      log('orders--//////////////${Provider.of<OrderProvider>(context, listen: false).orders}');
      log("respone------------------------" + response.data + " \n");

      for (var i = 0; i < orders.orders!.length; i++) {
        for (var j = 0; j < orders.orders![i].products!.length; j++) {
          Provider.of<OrderProvider>(context, listen: false)
              .order
              .add(orders.orders![i].products![j]);
        }
      }
      log(Provider.of<OrderProvider>(context, listen: false).order.toString());
      return response;
    } on DioError catch (error) {
      log(error.message);
      return error.response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
