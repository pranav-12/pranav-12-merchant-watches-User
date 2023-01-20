
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class ProductQtyandAmountContainer extends StatelessWidget {
  const ProductQtyandAmountContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red, width: 2),
                ),
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Quantity :',
                          style: TextStyle(fontSize: 18),
                        ),
                        ValueListenableBuilder(
                          valueListenable: totalQty,
                          builder: (context, value, child) => Text(
                            // value.totalQuantity().toString(),
                            value.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    ksizedBoxheight20,
                    Divider(
                      thickness: 1,
                      color: primaryBackgroundColor,
                    ),
                    ksizedBoxheight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          overflow: TextOverflow.visible,
                          'Total Amount :',
                          style: TextStyle(fontSize: 18),
                        ),
                        ValueListenableBuilder(
                          valueListenable: totalPrice,
                          builder: (context, value, child) => Text(
                            "₹ $value",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}
