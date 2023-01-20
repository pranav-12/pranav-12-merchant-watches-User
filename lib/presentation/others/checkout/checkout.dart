import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/presentation/others/payment/screen_payment.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';
import 'package:merchant_watches/presentation/widgets/products_builder_method.dart';
import 'package:provider/provider.dart';

import '../../../appication/other/address/address_provider.dart';
import '../../../constants/constants.dart';
import '../../widgets/checkoutcontinue.dart';

class ScreenCheckOut extends StatelessWidget {
  final Address address;
  const ScreenCheckOut({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<CheckOutProvider>(context, listen: false).qty = 1;
    final size = MediaQuery.of(context).size;
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
            ),
            ksizedBoxWidth20
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: [
                dataForProducts(),
                // Divider for separation
                Divider(
                  thickness: 1,
                  color: primaryBackgroundColor,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Order Summery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
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
                ),
                Divider(
                  thickness: 1,
                  color: primaryBackgroundColor,
                ),
                ksizedBoxheight20,
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 25, right: 50),
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
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
                          // ksizedBoxWidth10,

                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style: const TextStyle(fontSize: 17),
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
                                        Provider.of<AddressProvider>(context,
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
                Divider(
                  thickness: 1,
                  color: primaryBackgroundColor,
                ),
                ksizedBoxheight10,
              ],
            ),
          ),
          CheckOutContinueSection(
              size: size,
              elevatedButtonFunction: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenPayment(
                    address: address,
                    cartProducts: cartDataList.value,
                  ),
                ));
                // checkout.placeOrder(cartDataList.value,
                //     PaymentMethod.cod, address);
              }),
        ],
      ),
    );
  }
}
