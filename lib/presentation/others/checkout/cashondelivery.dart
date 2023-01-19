import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../appication/cart/cart_provider.dart';
import '../../../appication/home/home_provider.dart';
import '../../../appication/other/address/address_provider.dart';
import '../../../constants/constants.dart';
import '../../cart/quantity_widget.dart';

class ScreenCashOnDelivery extends StatelessWidget {
  final Product product;
  final Address address;
  final int? index;
  const ScreenCashOnDelivery(
      {super.key, required this.address, required this.product, this.index});

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
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          const Text(
            "Products",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // Row Contains the images and remove icon
                child: Row(
                  children: [
                    Container(
                      // height: size.height*0.1,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: cartImageColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(product.image![0]!

                          // imagevariation[index]
                          ),
                    ),
                    ksizedBoxWidth10,
                    // Expanded the full details about the cart
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row contains the Brand Name and WishList icon
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.41,
                            child: Text(
                              product.name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          // The Text for Color of the watch
                          SizedBox(
                            width: size.width * 0.5,
                            child: Text(
                              product.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          // row Contains the Rate and qty of the Watch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹ ${product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                child: Consumer<CheckOutProvider>(
                                  builder: (context, chechProv, child) => Row(
                                    children: [
                                      chechProv.qty > 1
                                          ? IconButton(
                                              onPressed: () {
                                                chechProv.qtyChangeFunc(false);
                                              },
                                              icon: Icon(
                                                  Icons.remove_circle_outline),
                                            )
                                          : SizedBox(),
                                      Text(chechProv.qty.toString()),
                                      IconButton(
                                        onPressed: () {
                                          chechProv.qtyChangeFunc(true);
                                        },
                                        icon: Icon(
                                            Icons.add_circle_outline_outlined),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(width: size.width*0.2,)
                              // Expanded(child: QuantityWidget(index: index)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ksizedBoxWidth10,
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
                  Consumer<CheckOutProvider>(
                    builder: (context, checkProv, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Quantity :',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          // value.totalQuantity().toString(),
                          checkProv.qty.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
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
                      Consumer<CheckOutProvider>(
                        builder: (context, checkoutPro, child) => Text(
                          "₹ ${checkoutPro.qty * product.price!}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ksizedBoxheight20,
          Divider(
            thickness: 1,
            color: primaryBackgroundColor,
          ),
          ksizedBoxheight10,
          const Text(
            "Order Now",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          ksizedBoxWidth10,
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
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
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
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {},
              child: const Text('Place Order'))
        ],
      ),
    );
  }
}
