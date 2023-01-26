import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchant_watches/infrastructure/others/orders/order_servises.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/cart_model.dart';
import '../../../domain/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  OrderModel? orders;

  void assignOrders(OrderModel orderModel) {
    orders = orderModel;
    notifyListeners();
  }

  String dateTime(DateTime? dates) {
    log(dates.toString());
    // final dates = deliveryDate;
    final dateFormat = DateFormat.yMMMEd().format(dates ?? DateTime.now());
    final splitedDate = dateFormat.split(' ');
    final dateSplit = splitedDate[2].split('');
    log("D///////////////////////////AAAAAAAAAAAAAAAAAAAAAAA$dateSplit");
    // return dateFormat;
    return '${splitedDate.first} ${dateSplit.getRange(0, 2).join()} ${splitedDate[1]}';
  }

  Container orderDetailsContainer(Size size, int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: size.width * 0.6,
      decoration: const BoxDecoration(color: Colors.white),
      child: Consumer<OrderProvider>(
        builder: (context, orderProv, child) {
          final orderDetails = orderProv.orders!.orders![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orderProv.dateTime(
                      orderDetails.deliveryDate!,
                    ),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ksizedBoxheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orderProv.dateTime(
                      orderDetails.orderDate,
                    ),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ksizedBoxheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (orderDetails.paymentStatus == true) ? 'Paid' : 'Pending',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ksizedBoxheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orderDetails.orderStatus.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ksizedBoxheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orderDetails.paymentType.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

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

  Container containerForShowPaymentDetails(
      BuildContext context, OrderProvider orderProv, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.of(context).size.height * 0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            // value.totalQuantity().toString(),
            "PRICE DETAILS (${totalQty(orderProv.orders!.orders![index].products!)} items) ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ksizedBoxheight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total MRP ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                // value.totalQuantity().toString(),
                "₹ ${orderProv.orders!.orders![index].totalPrice! + orderProv.orders!.orders![index].totalPrice! * 15 / 100}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          ksizedBoxheight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                overflow: TextOverflow.visible,
                'Discount on MRP',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "- ₹ ${orderProv.orders!.orders![index].totalPrice! * 15 / 100}",
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
            ],
          ),
          ksizedBoxheight10,
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                overflow: TextOverflow.visible,
                'Total Amount :',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "₹ ${orderProv.orders!.orders![index].totalPrice!}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int totalQty(List<ProductElement?>? products) {
    int qty = 0;
    for (var i = 0; i < products!.length; i++) {
      qty = qty + products[i]!.qty!;
    }
    return qty;
  }
}
