import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/wishlist/wishlist_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/wishlist/wishlist_servises.dart';
import 'package:provider/provider.dart';

class ScreenWishList extends StatelessWidget {
  ScreenWishList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    WishListServices().getWishListData(context);
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
          wishDataList.value[0].products!.isNotEmpty
              ? ValueListenableBuilder(
                  valueListenable: wishDataList,
                  builder: (context, wishList, child) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final products = wishList[0].products![index]!.product;
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          height: MediaQuery.of(context).size.height / 5.5,
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: cartImageColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(
                                      products!.image![0]!,
                                      // imagevariation[index]
                                    ),
                                  ),
                                  ksizedBoxWidth10,
                                  // Expanded the full details about the cart
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Row contains the Brand Name and WishList icon

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.45,
                                              child: Text(
                                                products.name!,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // The Text for Color of the watch
                                        SizedBox(
                                          width: size.width * 0.57,
                                          child: Text(
                                            products.description!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
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
                                              "₹ ${products.price!}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Container(
                                              // width: size.width / 4.4,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      itemCount: wishList[0].products!.length,
                    );
                  },
                )
              : Column(
                  children: [
                    Image.asset("assets/wishList.png"),
                    Center(
                      child: Container(
                        child: Text(
                          'Your List is Empty',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
