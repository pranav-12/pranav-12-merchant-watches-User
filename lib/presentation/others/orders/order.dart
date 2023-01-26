import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/orders/orders_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/others/orders/order_servises.dart';
import 'package:merchant_watches/presentation/others/orders/order_summary.dart';
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
        builder: (context, orderProv, child) => ListView.separated(
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
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.02,
                          height: size.width * 0.02,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: orderProv
                                          .orders!.orders![index].orderStatus !=
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
                        " on ${orderProv.dateTime(order.deliveryDate!)} as per your request",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    ksizedBoxheight20,
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = order.products![index]!.product!;
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
                                  child: Image.network(product.image![0]!),
                                ),
                                // ksizedBoxWidth10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.66,
                                      child: Text(
                                        product.name!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
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
                                    builder: (context) => ScreenOrderSummary(
                                        index: index,
                                        order:
                                            order),
                                  ),
                                );
                              },
                              title: 'View',
                              color: Colors.pinkAccent),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: CustomElevatedButton(
                              function: () {},
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
            itemCount: orderProv.orders!.orders!.length),
      ),
    );
  }
}
