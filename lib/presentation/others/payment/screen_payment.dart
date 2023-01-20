import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/presentation/others/payment/payment_provider.dart';
import 'package:merchant_watches/presentation/others/successfull_message_screen.dart';
import 'package:merchant_watches/presentation/widgets/checkoutcontinue.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/address_model.dart';
import '../../../domain/models/cart_model.dart';
import '../checkout/widgets/product_qty_amount.dart';

class ScreenPayment extends StatelessWidget {
  final List<ProductElement?> cartProducts;
  final Address address;
  const ScreenPayment(
      {super.key, required this.cartProducts, required this.address});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(children: [
          const Text('Payment'),
          ksizedBoxWidth10,
          Image.asset(
            'assets/credit-card.png',
            height: size.width * 0.1,
          )
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.red, Colors.green])),
                  // padding: EdgeInsets.all(10),

                  height: size.height * 0.32,
                  child: Card(
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment Method',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          ksizedBoxheight20,
                          Consumer<PaymentProvider>(
                            builder: (context, paymentProv, child) =>
                                GestureDetector(
                              onTap: () {
                                paymentProv
                                    .paymentMethodFunct(PaymentMethod.cod);
                              },
                              child: Container(
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: PaymentMethod.cod,
                                      groupValue: paymentProv.method,
                                      onChanged: (value) {
                                        paymentProv.paymentMethodFunct(
                                            PaymentMethod.cod);
                                      },
                                    ),
                                    const Text(
                                      'Cash on Delivery',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ksizedBoxheight20,
                          Consumer<PaymentProvider>(
                            builder: (context, paymentProv, child) =>
                                GestureDetector(
                              onTap: () => paymentProv.paymentMethodFunct(
                                  PaymentMethod.online_payment),
                              child: Container(
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: PaymentMethod.online_payment,
                                      groupValue: paymentProv.method,
                                      onChanged: (value) {
                                        paymentProv.paymentMethodFunct(
                                            PaymentMethod.online_payment);
                                      },
                                    ),
                                    const Text(
                                      'Credit/Debit/ATM Cards',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ksizedBoxheight20,
              const ProductQtyandAmountContainer(),
              ksizedBoxWidth20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/cards icons/visa.png",
                    width: size.width * 0.18,
                  ),
                  Image.asset(
                    "assets/cards icons/mastercard.png",
                    width: size.width * 0.18,
                  ),
                  Image.asset(
                    "assets/cards icons/rupay.png",
                    width: size.width * 0.18,
                  ),
                  Image.asset(
                    "assets/cards icons/razorpay.png",
                    width: size.width * 0.18,
                  ),
                ],
              ),
            ]),
          ),
          Consumer<PaymentProvider>(
            builder: (context, paymentProv, child) => CheckOutContinueSection(
              size: size,
              elevatedButtonFunction: () {
                if (paymentProv.method == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 1),
                      content: const Text('Please select Payment Method'),
                    ),
                  );
                  return;
                }
                if (paymentProv.method == PaymentMethod.cod) {
                  paymentProv.placeOrder(
                    cartProducts,
                    PaymentMethod.cod,
                    context,
                    address,
                  );
                 
                } else {}
              },
            ),
          )
        ],
      ),
    );
  }
}
