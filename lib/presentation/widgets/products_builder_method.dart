import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../appication/cart/cart_provider.dart';
import '../../appication/home/home_provider.dart';
import '../../constants/constants.dart';
import '../../domain/models/cart_model.dart';
import '../cart/quantity_widget.dart';
import '../cart/screen_cart.dart';

ValueListenableBuilder<List<ProductElement?>> dataForProducts() {
  return ValueListenableBuilder(
    valueListenable: cartDataList,
    builder: (context, cart, child) => cart.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final cartData = cart[index]!.product;
              return Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                  borderRadius: BorderRadius.circular(10)),
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
                                    width: MediaQuery.of(context).size.width *
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
                                    builder: (context, homeProvider, child) =>
                                        GestureDetector(
                                      onTap: () async {
                                        homeProvider.addOrRemoveWishListFucn(
                                          cartData.id!,
                                          context,
                                        );
                                      },
                                      child:
                                          searchIDForWishList(cartData) == true
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
  );
}