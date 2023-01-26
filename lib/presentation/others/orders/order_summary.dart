import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/orders/orders_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/presentation/home/screen_show_product.dart';
import 'package:merchant_watches/presentation/others/orders/widgets/widget_orders.dart';
import 'package:provider/provider.dart';

class ScreenOrderSummary extends StatelessWidget {
  final Order order;
  final int index;

  const ScreenOrderSummary(
      {super.key, required this.index, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Order Details'),
      ),
      body: ListView(children: [
        Consumer<OrderProvider>(
          builder: (context, orderPro, child) => Align(
            child: Container(
              padding: const EdgeInsets.only(left: 90, right: 100),
              height: size.width * 0.6,
              // width: size.width * 0.6,
              decoration: BoxDecoration(color: primaryBackgroundColor),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: orderPro.orders!.orders![index].products!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenShowProductDetails(
                              product: order.products![index]!.product!),
                        ),
                      );
                    },
                    child: Container(
                      color: primaryBackgroundColor,
                      width: size.width * 0.5,
                      // color: Colors.white,
                      // height: size.width * 0.6,
                      child: Center(
                        child: Image.network(
                            order.products![index]!.product!.image![0]!),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ),
          ),
        ),
        Consumer<OrderProvider>(
          builder: (context, orderProv, child) => orderProv
              .containerForShowPaymentDetails(context, orderProv, index),
        ),
        ksizedBoxheight20,
        DeliveryAddressContainer(size: size, index: index),
        ksizedBoxheight20,
        Provider.of<OrderProvider>(context, listen: false)
            .orderDetailsContainer(size, index),
        ksizedBoxheight20,
      ]),
    );
  }
}
