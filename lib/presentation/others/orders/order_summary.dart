import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/bottom_nav_bar_provider.dart';
import 'package:merchant_watches/appication/other/orders_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:merchant_watches/presentation/home/screen_show_product.dart';
import 'package:merchant_watches/presentation/others/orders/widgets/widget_orders.dart';
import 'package:merchant_watches/presentation/widgets/bottom_navigation_bar.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ScreenOrderSummary extends StatelessWidget {
  final bool isNavigatedbysuccessFullScreen;
  final Order order;

  const ScreenOrderSummary({
    super.key,
    required this.order,
    required this.isNavigatedbysuccessFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Order Details'),
      ),
// Body
      body: ListView(
        children: [
          Consumer<OrderProvider>(
            builder: (context, orderPro, child) => Align(
              child: Container(
                padding: const EdgeInsets.only(left: 90, right: 100),
                height: size.width * 0.6,
                decoration: BoxDecoration(color: primaryBackgroundColor),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: order.products!.length,
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
// For Show the Payment Details
          const WidgetsForOrder()
              .containerForShowPaymentDetails(context, order.id!),
          ksizedBoxheight10,
// For Show the  Delivery Address Details
          WidgetsForOrder(size: size, orders: order),
          ksizedBoxheight10,
// For  Show the  Order Details
          const WidgetsForOrder().orderDetailsContainer(
              id: order.id!, size: size, context: context),
          Visibility(
            visible: isNavigatedbysuccessFullScreen,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                  function: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                        builder: (context) {
                          Provider.of<BottomNavBarProvider>(context,
                                  listen: false)
                              .selectedCurrentIndex = 0;

                          return CustomBNavBar();
                        },
                      ), (route) => false),
                  title: 'Continue Shopping',
                  color: Colors.pinkAccent.shade200),
            ),
          )
        ],
      ),
    );
  }
}
