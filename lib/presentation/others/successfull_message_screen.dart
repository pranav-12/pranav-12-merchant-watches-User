import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/orders_provider.dart';
import 'package:merchant_watches/presentation/others/orders/order_summary.dart';
import 'package:provider/provider.dart';

class ScreenSuccessFull extends StatelessWidget {
  const ScreenSuccessFull({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 4),
      () => const Text('Successfully Ordered'),
    );
    return Scaffold(
// Body
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 2.0),
        onEnd: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ScreenOrderSummary(
                  isNavigatedbysuccessFullScreen: true,
                  order:
                      Provider.of<OrderProvider>(context).orders!.orders!.last),
            ),
            (route) => false),
        duration: const Duration(seconds: 3),
        builder: (context, value, child) {
          return Center(child: Image.asset("assets/successfully-done.gif"));
        },
      ),
    );
  }
}
