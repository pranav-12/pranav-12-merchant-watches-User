import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/appication/other/payment/payment_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/presentation/cart/widgets/order_details.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';
import 'package:merchant_watches/presentation/widgets/products_builder_method.dart';
import 'package:provider/provider.dart';

import '../../../appication/other/address/address_provider.dart';
import '../../../constants/constants.dart';

class ScreenCheckOut extends StatelessWidget {
  final Address address;
  const ScreenCheckOut({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Checkout'),
            SizedBox(
              height: 30,
              child: Image.asset("assets/cart/shopping.png"),
            ),
            ksizedBoxWidth20
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: cartDataList,
        builder: (context, cartlist, child) => cartlist.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(5),
                      children: [
                        dataForProducts(cartDataList.value),
                        ksizedBoxheight10,
                        const OrderDetails(),
                        ksizedBoxheight20,
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 25, right: 50),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: cartImageColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Shipping To :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  // ksizedBoxWidth10,

                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ksizedBoxheight10,
                                        Text(
                                          "Name : ${address.fullName}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.6,
                                          child: Text(
                                            'Address : ${address.address}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Text(
                                          'Place : ${address.place}',
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          'State : ${address.state}',
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          'PIN : ${address.pin}',
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          'Phone : ${address.phone}',
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        ksizedBoxheight10,
                                        Divider(color: primaryBackgroundColor),
                                        Align(
                                          child: CustomElevatedButton(
                                              function: () {
                                                Provider.of<AddressProvider>(
                                                        context,
                                                        listen: false)
                                                    .showSaveButtonFunc(false);
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.indigo,
                                              title: 'Change Address'),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ksizedBoxheight20,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    height: size.width * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<PaymentProvider>(
                              builder: (context, paymentProv, child) =>
                                  ElevatedButton(
                                onPressed: () {
                                  paymentProv.placeOrder(cartDataList.value, 
                                      PaymentMethod.cod, context, address);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: Colors.pink.shade400,
                                    elevation: 6,
                                    fixedSize: const Size(150, 60)),
                                child: const Text('Cash on Delivery'),
                              ),
                            ),
                            Consumer<CheckOutProvider>(
                              builder: (context, checkOut, child) =>
                                  ValueListenableBuilder(
                                valueListenable: totalPrice,
                                builder: (context, value, child) =>
                                    ElevatedButton(
                                  onPressed: () {
                                    // _razorPay;
                                    checkOut.payment(context, address, value);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.pink.shade400,
                                      elevation: 6,
                                      fixedSize: const Size(150, 60)),
                                  child: const Text('Online Transaction'),
                                ),
                              ),
                            )
                          ]),
                    ),
                  )
                ],
              )
            : Center(
                heightFactor: 1,
                child: Image.asset('assets/cart/empty_cart.png'),
              ),
      ),
    );
  }
}
