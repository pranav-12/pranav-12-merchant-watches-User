import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/orders/orders_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/others/orders/order_servises.dart';
import 'package:merchant_watches/presentation/others/orders/order_summary.dart';
import 'package:merchant_watches/presentation/widgets/bottom_navigation_bar.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ScreenOrders extends StatelessWidget {
  const ScreenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await OrderServices().getOrders(context);
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
          builder: (context, orderProv, child) => orderProv
                  .orders!.orders!.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final order = orderProv.orders!.orders![index];
                    // log("ORSDER ${order.cancelDate}");
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              order.orderStatus == 'confirmed'.toUpperCase()
                                  ? " on ${orderProv.dateTime(order.deliveryDate)} as per your request"
                                  : " on ${orderProv.dateTime(order.cancelDate)} as per your request -ORDER CANCELED",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          ksizedBoxheight20,
                          ListView.separated(
                              reverse: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final product =
                                    order.products![index]!.product!;
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  height: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child:
                                            Image.network(product.image![0]!),
                                      ),
                                      // ksizedBoxWidth10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.66,
                                            child: Text(
                                              product.name!,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          // ksizedBoxheight10,
                                          SizedBox(
                                            width: size.width * 0.66,
                                            child: Text(product.description!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: order.products!.length),
                          ksizedBoxheight20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  itemCount: orderProv.orders!.orders!.length)
              : Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/ordersEmpty.png",
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.28, left: size.width * 0.23),
                        child: const Text(
                          'No Orders',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
