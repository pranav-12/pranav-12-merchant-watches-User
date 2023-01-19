import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/infrastructure/wishlist/wishlist_servises.dart';
import 'package:provider/provider.dart';

import '../../domain/models/products_model.dart';
import '../home/screen_show_product.dart';

class ScreenWishList extends StatelessWidget {
  const ScreenWishList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      log('message');
      await WishListServices().getWishListData(context);
      log('message1');
    });

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('My WishList'),
            SizedBox(
              height: 40,
              child: Image.asset("assets/cart/wishlist.png"),
            ),
          ],
        ),
      ),
// Body
      body: ValueListenableBuilder(
        valueListenable: wishDataList,
        builder: (context, wishList, child) {
          return wishList.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = wishList[index]!.product;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ScreenShowProductDetails(product: product),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        height: MediaQuery.of(context).size.height * 0.19,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // Row Contains the images and remove icon
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // height: MediaQuery.of(context).size.height*0.2,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: cartImageColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    product!.image![0]!, fit: BoxFit.fill,
                                    // imagevariation[index]
                                  ),
                                ),
                                ksizedBoxWidth10,
                                // Expanded the full details about the cart
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Row contains the Brand Name and WishList icon

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.49,
                                            child: Text(
                                              product.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Consumer<HomeProvider>(
                                            builder: (context, value, child) =>
                                                GestureDetector(
                                              onTap: () {
                                                value.addOrRemoveWishListFucn(
                                                    product.id!, context);
                                              },
                                              child: const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // The Text for Color of the watch
                                      SizedBox(
                                        width: size.width * 0.58,
                                        child: Text(
                                          product.description!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // row Contains the Rate and qty of the Watch
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "₹ ${product.price!}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Container(
                                            // width: size.width / 4.4,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Consumer<HomeProvider>(
                                              builder: (context, value,
                                                      child) =>
                                                  searchIDForWishList(
                                                            product,
                                                          ) ==
                                                          false
                                                      ? GestureDetector(
                                                          onTap: () =>
                                                              value.addToCart(
                                                                  product,
                                                                  context),
                                                          child: Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              const Text(
                                                                  'Add to'),
                                                              SizedBox(
                                                                height: 30,
                                                                child: Image.asset(
                                                                    "assets/cart/bag_for_wishlist.png"),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          width:
                                                              size.width * 0.06,
                                                          child: Image.asset(
                                                              "assets/cart/added.png"),
                                                        ),
                                            ),
                                          ),
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
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: wishList.length,
                )
              : Column(
                  children: [
                    Image.asset("assets/wishList.png"),
                    const Center(
                      child: Text(
                        'Your List is Empty',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }

  bool searchIDForWishList(Product product) {
    bool findProductId = false;
    for (var i = 0; i < cartDataList.value.length; i++) {
      if (cartDataList.value[i]!.product!.id == product.id) {
        return findProductId = true;
      }
    }

    return findProductId;
  }
}
