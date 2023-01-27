import 'package:flutter/material.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:provider/provider.dart';

import '../../../../appication/other/orders/orders_provider.dart';
import '../../../../constants/constants.dart';

class DeliveryAddressContainer extends StatelessWidget {
  const DeliveryAddressContainer(
      {Key? key, required this.size,  required this.orders})
      : super(key: key);
  final Order orders;
  final Size size;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: size.width * 0.7,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
          Consumer<OrderProvider>(
            builder: (context, orderProv, child) {
              final address = orders;
              return SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ksizedBoxheight10,
                    Text(
                      "Name : ${address.fullName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Text(
                        'Address : ${address.address}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                    Text(
                      'Place : ${address.place}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'State : ${address.state}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'PIN : ${address.pin}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'Phone : ${address.phone}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    ksizedBoxheight10,
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
