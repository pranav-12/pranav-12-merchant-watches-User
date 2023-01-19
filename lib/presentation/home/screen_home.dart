import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/get_products_details/products_services.dart';
import 'package:merchant_watches/presentation/home/screen_show_product.dart';
import 'package:merchant_watches/presentation/home/widgets/carousel.dart';
import 'package:merchant_watches/presentation/home/widgets/drawer.dart';
import 'package:merchant_watches/presentation/widgets/loading_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/cart_model.dart';
import '../../domain/models/products_model.dart';
import '../../domain/models/wishlist_model.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({
    super.key,
  });
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('1');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      log('2');
      await ProductServices().getProducts(context);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final id = sharedPreferences.getString('UserId');
      Provider.of<HomeProvider>(context, listen: false).addUserId(id!);

      log(id.toString());
    });
    log('3');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 90,
        backgroundColor: primaryBackgroundColor,
        leading: Image.asset('assets/logo/Merchant Watches-icon.png',
            fit: BoxFit.fill),
        leadingWidth: 100,
        title: Text(
          'MW',
          style: GoogleFonts.ultra(color: primaryFontColor, fontSize: 30),
        ),
      ),
      endDrawer: DrawerDesign(size: size),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => homeProvider.loadingBool ==
                false
            ? ListView(
                children: [
                  ksizedBoxheight10,
                  const CarouselForImage(),
                  ksizedBoxheight10,
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Products',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: productDataList,
                    builder: (context, productsList, child) {
                      return GridView.count(
                        childAspectRatio: 0.70,
                        mainAxisSpacing: 10,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                          productsList.length,
                          (index) {
                            final product = productsList[index];
                            log(product.toString());

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenShowProductDetails(
                                            product: productsList[index]!,
                                            index: index),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Card(
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          color: cartImageColor,
                                          height: size.width / 2.6,
                                          width: size.width,
                                          child: Image.network(
                                            product!.image![0]!,
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        ksizedBoxheight10,
                                        Divider(
                                            color: primaryBackgroundColor,
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: size.width / 3.5,
                                              child: Text(
                                                product.name!,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ValueListenableBuilder(
                                              valueListenable: wishDataList,
                                              builder:
                                                  (context, wishdata, child) =>
                                                      GestureDetector(
                                                onTap: () async {
                                                  homeProvider
                                                      .addOrRemoveWishListFucn(
                                                    product.id!,
                                                    context,
                                                  );
                                                },
                                                child: searchIDForWishList(
                                                            product: product,
                                                            wish: true,
                                                            wisList:
                                                                wishdata) ==
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
                                        ksizedBoxheight10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹ ${product.price}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: ValueListenableBuilder(
                                                valueListenable: cartDataList,
                                                builder:
                                                    (context, cartData, child) {
                                                  return searchIDForWishList(
                                                              product: product,
                                                              wish: false,
                                                              cartElement:
                                                                  cartData) ==
                                                          false
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            homeProvider
                                                                .addToCart(
                                                                    product,
                                                                    context);
                                                          },
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
                                                              size.width * 0.07,
                                                          child: Image.asset(
                                                              "assets/cart/added.png"),
                                                        );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }

  bool searchIDForWishList(
      {required Product product,
      required bool wish,
      List<ProductElementForWishList?>? wisList,
      List<ProductElement?>? cartElement}) {
    bool findProductId = false;
    if (wish == true) {
      for (var i = 0; i < wisList!.length; i++) {
        if (wisList[i]!.product!.id == product.id) {
          return findProductId = true;
        }
      }
    } else {
      log('entry');
      for (var i = 0; i < cartElement!.length; i++) {
        log('---------------message');
        if (cartElement[i]!.product!.id == product.id) {
          return findProductId = true;
        }
      }
      log("FIND__________________________ID" + findProductId.toString());
    }

    return findProductId;
  }

  // void addToCart(Product product, int index, BuildContext context) {
  //   // log(value[index]["_id"].toString());

  //   try {
  //     log(userId.toString());
  //     // log('cart------------$cart');
  //     CartService().addToCart(product, context);
  //   } catch (e) {
  //     log("cartbuttonpressed:--=-=-=-=-$e");
  //   }
  // }
}
