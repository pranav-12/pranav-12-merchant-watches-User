import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../appication/product_details_provider/product_provider.dart';

class ScreenWishList extends StatelessWidget {
  const ScreenWishList({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) =>
// Container contains of the cart details
                  Container(
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
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: cartImageColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                  "https://cdn.shopify.com/s/files/1/0997/6284/products/Side04.png?v=1671685358"
                                  // imagevariation[index]
                                  ),
                            ),
                            ksizedBoxWidth10,
// Expanded the full details about the cart
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
// Row contains the Brand Name and WishList icon
                                      Text(
                                        'Rollex',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
// The Text for Color of the watch
                                      Text(
                                        'Color',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
// row Contains the Rate and qty of the Watch
                                      Text(
                                        "₹2344",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                      ksizedBoxheight20,
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            const Text('Add to'),
                                            SizedBox(
                                              height: 30,
                                              child: Image.asset(
                                                  "assets/cart/bag_for_wishlist.png"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
              itemCount: 4),
        ],
      ),
    );
  }
}
