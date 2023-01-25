import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/presentation/cart/widgets/order_details.dart';
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
      backgroundColor: Colors.grey.shade300,
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
      body: ValueListenableBuilder(
        valueListenable: cartDataList,
        builder: (context, cart, child) => cartDataList.value.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView(children: [
                      dataForProducts(cart),

                      // Divider for separation
                      ksizedBoxheight20,
                      const OrderDetails(),
                      ksizedBoxheight20,
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                          function: () {
                            if (cartDataList.value.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                          color: Colors.pinkAccent),
                    ),
                  )
                ],
              )
            : Center(
                // heightFactor: 1,
                child: Image.asset('assets/cart/empty_cart.png'),
              ),
      ),
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
