
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/order_model.dart';

class OrderServices {
  final dio = Dio();

  OrderServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

  Future<Response?> createOrder(OrderModel order) async {
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
}
