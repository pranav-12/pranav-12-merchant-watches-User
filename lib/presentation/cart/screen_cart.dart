import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/presentation/others/address/screen_address.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';

import '../../domain/models/products_model.dart';
import '../widgets/products_builder_method.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await CartService().getDataCart(context);
    });

    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('My Cart'),
            SizedBox(height: 40, child: Image.asset("assets/cart/bag.png"))
          ],
        ),
      ),
// body
      body: ListView(children: [
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

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
              function: () {
                if (cartDataList.value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Your Cart is Empty'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScreenAddress(),
                    ),
                  );
                }
              },
              title: 'Order Now',
              color: Colors.indigo),
        )
      ]),
    );
  }
}

bool searchIDForWishList(Product product) {
  bool findProductId = false;
  for (var i = 0; i < wishDataList.value.length; i++) {
    if (wishDataList.value[i]!.product!.id == product.id) {
      return findProductId = true;
    }
  }

  return findProductId;
}
