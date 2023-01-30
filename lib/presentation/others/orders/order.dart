import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/appication/other/orders_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:merchant_watches/infrastructure/others/orders/order_servises.dart';
import 'package:merchant_watches/presentation/others/orders/order_summary.dart';
import 'package:merchant_watches/presentation/others/orders/widgets/widgets_for_showingthe_orderdproducts.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_bar.dart';

class ScreenOrders extends StatelessWidget {
  const ScreenOrders({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<HomeProvider>(context, listen: false).loading(true);
      await OrderServices().getOrders(context);
      Future.delayed(
          const Duration(seconds: 1),
          () =>
              Provider.of<HomeProvider>(context, listen: false).loading(false));
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
// Appbar
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Orders'),
      ),
// Body
      body: Consumer<OrderProvider>(
        builder: (context, orderProv, child) {
          return Provider.of<OrderProvider>(
                    context,
                  ).isLooding ==
                  false
              ? orderProv.orders!.orders!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final order = orderProv.orders!.orders![index];
                        return Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
// Row contains the container For If order is confirmed or Not if Not it's Shows the Canceled Text
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.02,
                                    height: size.width * 0.02,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: orderProv.orders!.orders![index]
                                                    .orderStatus !=
                                                'confirmed'
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                  ksizedBoxWidth10,
                                  Text(
                                    order.orderStatus!.toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
// For Order Confirmed or Canceled
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  order.orderStatus == 'confirmed'
                                      ? " on ${orderProv.dateTime(order.deliveryDate)} as per your request"
                                      : " on ${orderProv.dateTime(order.cancelDate)} as per your request -ORDER CANCELED",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ),
                              ksizedBoxheight20,
                              WidgetsForShowtheOrderedProducts(
                                  order: order, size: size),
                              ksizedBoxheight20,
// Row contains the elevated button View for view the Orderd Products and also the Cancel Button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: CustomElevatedButton(
                                        function: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenOrderSummary(
                                                isNavigatedbysuccessFullScreen:
                                                    false,
                                                order: order,
                                              ),
                                            ),
                                          );
                                        },
                                        title: 'View',
                                        color: Colors.pinkAccent),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: CustomElevatedButton(
                                        function: () async {
                                          log("order cancel date:=-------${order.cancelDate.runtimeType}");
                                          log(order.id!);
                                          orderProv.cancelButtonFunc(
                                              context, order.id!);
                                        },
                                        title: 'Cancel',
                                        color: Colors.redAccent),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: orderProv.orders!.orders!.reversed.length)
// if list is Empty the empty image shows
                  : Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/ordersEmpty.png",
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.28,
                                left: size.width * 0.23),
                            child: const Text(
                              'No Orders',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    )
              : const LoadingWidget();
        },
      ),
    );
  }
}
