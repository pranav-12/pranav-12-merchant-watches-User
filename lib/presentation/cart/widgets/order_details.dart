import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
// Value Notifier For the TotalQuantity
          ValueListenableBuilder(
            valueListenable: totalQty,
            builder: (context, value, child) => Text(
              // value.totalQuantity().toString(),
              "PRICE DETAILS ($value items)",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ksizedBoxheight10,
// Row Contains the Total MRP and its Value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total MRP ',
                style: TextStyle(fontSize: 18),
              ),
              ValueListenableBuilder(
                valueListenable: totalPrice,
                builder: (context, value, child) => Text(
                  "₹ ${value + value * 15 / 100}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row Contains the Discount on MRP and its Value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                overflow: TextOverflow.visible,
                'Discount on MRP',
                style: TextStyle(fontSize: 18),
              ),
              ValueListenableBuilder(
                valueListenable: totalPrice,
                builder: (context, value, child) => Text(
                  "- ₹ ${value * 15 / 100}",
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
              ),
            ],
          ),
          ksizedBoxheight10,
          const Divider(
            color: Colors.grey,
          ),
// Row Contains the Total Amount and its Value
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
    );
  }
}
