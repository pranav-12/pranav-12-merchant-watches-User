import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/appication/cart/cart_provider.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/cart_model.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/infrastructure/get_products_details/products_services.dart';
import 'package:merchant_watches/presentation/home/screen_show_product.dart';
import 'package:merchant_watches/presentation/home/widgets/carousel.dart';
import 'package:merchant_watches/presentation/home/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({
    super.key,
  });
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final id = sharedPreferences.getString('UserId');
      log(id.toString());
      HomeProvider().addUserId(id!);
    });
    ProductServices().getProducts();
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
        body: ListView(
          children: [
            ksizedBoxheight10,
            const CarouselForImage(),
            ksizedBoxheight10,
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: productDataList,
              builder: (context, value, child) => GridView.count(
                childAspectRatio: 0.66,
                mainAxisSpacing: 10,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  value.length,
                  (index) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ScreenShowProductDetails(index: index),
                    )),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
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
                                  value[index]["image"][0],
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ksizedBoxheight10,
                              Divider(
                                  color: primaryBackgroundColor, thickness: 1),
                              Consumer<HomeProvider>(
                                builder: (context, homeProvider, child) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      width: size.width / 3.5,
                                      child: Text(
                                        value[index]['name'],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    homeProvider.addToCartList
                                            .contains(value[index])
                                        ? GestureDetector(
                                            onTap: () => homeProvider
                                                .addOrRemoveCartFucn(
                                                    true, index),
                                            child: const Icon(
                                                Icons.favorite_border),
                                          )
                                        : GestureDetector(
                                            onTap: () => homeProvider
                                                .addOrRemoveCartFucn(
                                                    false, index),
                                            child: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                          )
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: const Icon(Icons.favorite_border),)
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹ ${value[index]['price']}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        addToCart(value, index, context),
                                    icon: const Icon(Icons.shopping_cart),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void addToCart(List<dynamic> value, int index, BuildContext context) {
    log(value[index]["_id"].toString());
    // if (cartDataList.value.isNotEmpty) {
    //   try {
    //     for (var i = 0; i < cartDataList.value.length; i++) {
    //       if (cartDataList.value[i]["_id"] == value[index]["_id"]) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: const Text(
    //               'already added in cart',
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 17,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             duration: const Duration(seconds: 3),
    //             padding: const EdgeInsets.all(20),
    //             backgroundColor: Colors.black,
    //             elevation: 5,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10)),
    //             behavior: SnackBarBehavior.floating,
    //           ),
    //         );
    //       } else {
    // for (var i = 0; i < cartDataList.value.length; i++) {
    //   Provider.of<CartProvider>(context).totalAmount = {
    //     Provider.of<CartProvider>(context).totalAmount! +
    //         cartDataList.value[i]["price"]
    //   } as int?;
    // }
    try {
      log(userId.toString());
      log(value[index]["_id"]);

      final cart = CartModel.create(
        userId: userId,
        productDatasId: value[index],
        qty: Provider.of<CartProvider>(context, listen: false).qty,
      );
      log('cart------------$cart');
      CartService().addToCart(cart);
    } catch (e) {
      log("cartbuttonpressed:--=-=-=-=-$e");
    }
    //       }
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //   }
    // }
  }
}
