// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/infrastructure/get_products_details/products_services.dart';
import 'package:merchant_watches/infrastructure/wishlist/wishlist_servises.dart';
import 'package:merchant_watches/presentation/home/screen_show_product.dart';
import 'package:merchant_watches/presentation/home/widgets/carousel.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ProductServices().getProducts(context);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final id = sharedPreferences.getString('UserId');
      Provider.of<HomeProvider>(context, listen: false).addUserId(id!);
      await WishListServices().getWishListData(context);
      await CartService().getDataCart(context);

      log(id.toString());
    });

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
                      return SingleChildScrollView(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  
                              mainAxisSpacing: 0,
                              // mainAxisExtent: 2,
                              crossAxisSpacing: 0,
                              childAspectRatio: 0.7,
                      
                              crossAxisCount: 2,
                            ),
                            // mainAxisSpacing: 10,
                            itemCount: productsList.length,
                            //
                      
                            // physics: const ScrollPhysics(),
                            // shrinkWrap: true,
                            // crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              final product = productsList[index];
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
                                child: Padding(
                                  padding: EdgeInsets.zero,
                                  child: Card(
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Container(
                                            color: Colors.white,
                                            // width: size.width / 3.5,
                                            child: Text(
                                              product.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ksizedBoxheight10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "₹ ${product.price! + product.price! * 15 / 100}",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        // fontSize: 20,
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "\t ₹ ${product.price!}",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
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
                                                              wisList: wishdata) ==
                                                          true
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          size: 30,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(
                                                          size: 30,
                                                          Icons.favorite_border,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                      
                              //  List.generate(
                      
                              //     (index) {
                      
                              //     },
                              //   ),
                            }),
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
}
