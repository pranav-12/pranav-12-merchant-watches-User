import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/cart/cart_provider.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/presentation/cart/quantity_widget.dart';
import 'package:provider/provider.dart';

import '../../appication/product_details_provider/product_provider.dart';
import '../../domain/models/products_model.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('My Cart'),
            SizedBox(height: 40, child: Image.asset("assets/cart/bag.png"))
          ],
        ),
      ),
// body
      body: ListView(children: [
        ValueListenableBuilder(
          valueListenable: cartDataList,
          builder: (context, cart, child) => cart.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cartData = cart[index]!.product;
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      height: MediaQuery.of(context).size.height / 5,
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
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: cartImageColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(cartData!.image![0]!

                                        // imagevariation[index]
                                        ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .removeFromCart(context, cartData);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              ksizedBoxWidth10,
                              // Expanded the full details about the cart
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row contains the Brand Name and WishList icon
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.41,
                                          child: Text(
                                            cartData.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Consumer<HomeProvider>(
                                          builder:
                                              (context, homeProvider, child) =>
                                                  GestureDetector(
                                            onTap: () async {
                                              homeProvider
                                                  .addOrRemoveWishListFucn(
                                                cartData.id!,
                                                context,
                                              );
                                            },
                                            child:
                                                searchIDForWishList(cartData) ==
                                                        true
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.favorite_border,
                                                      ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // The Text for Color of the watch
                                    Text(
                                      cartData.description!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // row Contains the Rate and qty of the Watch
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "₹ ${cartData.price}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        QuantityWidget(index: index),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: cart.length,
                )
              : Center(
                  heightFactor: 1,
                  child: Image.asset('assets/cart/empty_cart.png'),
                ),
        ),

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

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Payment Via',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.5, 50),
                    backgroundColor: primaryBackgroundColor,
                    // padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Cash On Delivery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ksizedBoxheight10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.5, 50),
                    backgroundColor: primaryBackgroundColor,
                    // padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Card or UPI',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
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
}
