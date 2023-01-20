import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../appication/other/checkout_provider.dart';
import '../../constants/constants.dart';
import '../others/payment/screen_payment.dart';

class CheckOutContinueSection extends StatelessWidget {
  final void Function()? elevatedButtonFunction;
  const CheckOutContinueSection({
    Key? key,
    required this.size, this.elevatedButtonFunction,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.redAccent, Colors.greenAccent]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: totalPrice,
                  builder: (context, value, child) => Text(
                    "₹ $value",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Consumer<CheckOutProvider>(
                  builder: (context, checkout, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.4, 100),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: elevatedButtonFunction,
                      child: const Text('Continue')),
                )
              ],
            ),
          ),
        ));
  }
}
