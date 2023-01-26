import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/cart_model.dart';
import '../../../domain/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<ProductElement?> order = [];
  OrderModel? orders;
  String dateTime(DateTime? deliveryDate) {
    final dates = deliveryDate;
    final dateFormat = DateFormat.yMMMEd().format(dates!);
    final splitedDate = dateFormat.split(' ');
    final dateSplit = splitedDate[2].split('');
    log("D///////////////////////////AAAAAAAAAAAAAAAAAAAAAAA" +
        dateSplit.toString());
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
