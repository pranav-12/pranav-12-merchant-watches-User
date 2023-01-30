import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchant_watches/infrastructure/others/orders/order_servises.dart';
import '../../constants/constants.dart';
import '../../domain/models/cart_model.dart';
import '../../domain/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  OrderModel? orders;
  bool isLooding = false;

// For Assign the Orders for getting the Data From Api's
  void assignOrders(OrderModel orderModel) {
    orders = orderModel;
    notifyListeners();
  }

// For Parse the Data As We Want the Format
  String dateTime(DateTime? dates) {
    log(dates.toString());
    final dateFormat = DateFormat.yMMMEd().format(dates ?? DateTime.now());
    final splitedDate = dateFormat.split(' ');
    final dateSplit = splitedDate[2].split('');
    return '${splitedDate.first} ${dateSplit.getRange(0, 2).join()} ${splitedDate[1]}';
  }

// For Find OrderId for Pass the Order to Show the Order Summary
  Order findIdForGettingOrders(String id) {
    Order? order;
    for (var i = 0; i < orders!.orders!.length; i++) {
      if (orders!.orders![i].id == id) {
        order = orders!.orders![i];
        break;
      }
    }
    return order!;
  }

// For Cancel the Order
  void cancelButtonFunc(BuildContext context, String id) {
    showBottomSheet(
      backgroundColor: Colors.grey.shade200,
      enableDrag: true,
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Column(children: [
          const Text(
            'Do you want to cancel your order?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ksizedBoxheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.clear)),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: IconButton(
                    onPressed: () async {
                      Response? response =
                          await OrderServices().cancelOrder(id, context);
                      await OrderServices().getOrders(context);
                      Map<String, dynamic> responseMessage =
                          jsonDecode(response!.data);
                      String message = responseMessage["message"];
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: response.statusCode == 200
                              ? Colors.green
                              : Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          content: Text(
                            message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                      notifyListeners();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check)),
              )
            ],
          )
        ]),
      ),
    );
    notifyListeners();
  }

// For find the TotalQuantity
  int totalQty(List<ProductElement?>? products) {
    int qty = 0;
    for (var i = 0; i < products!.length; i++) {
      qty = qty + products[i]!.qty!;
    }
    return qty;
  }
}
