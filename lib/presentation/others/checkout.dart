import 'package:flutter/material.dart';
import 'package:merchant_watches/presentation/others/address/shipping_address.dart';

import '../../constants/constants.dart';

enum PaymentMethodForPlaceOrder { cashOnDelivery, card }

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Checkout'),
            SizedBox(
              height: 30,
              child: Image.asset("assets/cart/shopping.png"),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping Address',
                style: TextStyle(fontSize: 17),
              ),
              TextButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ShippingAddress(),
                      )),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Address'))
            ],
          ),
          ksizedBoxheight10,
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: cartImageColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Name\n32/3,Kamarajar Road , kkpudur\ncoimbatore\n641038\nph:1234567890',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          ksizedBoxheight20,
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 16),
          ),
          ksizedBoxheight10,
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                      value: PaymentMethodForPlaceOrder,
                      groupValue: PaymentMethodForPlaceOrder,
                      onChanged: (value) {},
                    ),
                    const Text(
                      'Cash On Delivery',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                ksizedBoxheight10,
                Row(
                  children: [
                    Radio(
                      value: PaymentMethodForPlaceOrder.cashOnDelivery,
                      groupValue: PaymentMethodForPlaceOrder,
                      onChanged: (value) {},
                    ),
                    const Text(
                      'Card',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ksizedBoxheight20,
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ShippingAddress(),
                ));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(MediaQuery.of(context).size.width / 2.5, 50),
                backgroundColor: primaryBackgroundColor,
                // padding: const EdgeInsets.all(15),
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
