// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/appication/other/orders/orders_provider.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:provider/provider.dart';

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
    try {
      Response response = await dio.get("$orderUrl/");
      Map<String, dynamic> data = await json.decode(response.data);
      final orders = OrderModel.fromJson(data);
      Provider.of<OrderProvider>(context, listen: false).assignOrders(orders);
      log('orders--//////////////${Provider.of<OrderProvider>(context, listen: false).orders}');
      log('respone------------------------' + response.data);
      
      return response;
    } on DioError catch (error) {
      log(error.message);
      return error.response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Response?> cancelOrder(String id, BuildContext context) async {
    try {
      Response response = await dio.patch(orderUrl, data: {"orderId": id});
      Map<String, dynamic> data = await json.decode(response.data);
      final orders = OrderModel.fromJson(data);
      Provider.of<OrderProvider>(context, listen: false).assignOrders(orders);
      log(response.data);
      return response;
    } on DioError catch (er) {
      log("DioError in Cancel Order ---------${er.response!.statusMessage}");

      return er.response;
    } catch (e) {
      log("ERROR in CancelOrder$e");
      return null;
    }
  }
}
