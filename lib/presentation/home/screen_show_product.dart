import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/appication/product_details_provider/product_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/presentation/cart/screen_cart.dart';
import 'package:provider/provider.dart';

class ScreenShowProductDetails extends StatelessWidget {
  final Product product;
  final int? index;
  const ScreenShowProductDetails(
      {super.key, required this.product, this.index});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await CartService().getDataCart(context);
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
// appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<HomeProvider>(
              builder: (context, homeProvider, child) => GestureDetector(
                onTap: () async {
                  homeProvider.addOrRemoveWishListFucn(
                    product.id!,
                    context,
                  );
                },
                child: searchIDForWishList(product, true) == true
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
// sized Box for that contains the top images
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 2.5,
          child: Consumer<ProductDetailsProvider>(
            builder: (context, value, child) =>
                Image.network(product.image![value.imgList]!),
          ),
        ),
        ksizedBoxheight10,
// container for each photo every angle
        Container(
          height: size.width * 0.2,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
          child: Consumer<ProductDetailsProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                growable: true,
                4,
                (index1) => Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      value.changeImage(index1);
                    },
                    child: Image.network(product.image![index1]!),
                  ),
                ),
              ),
            ),
          ),
        ),
        ksizedBoxheight20,

        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "₹ ${product.price! + product.price! * 15 / 100}",
                style: const TextStyle(
                  color: Colors.grey,
                  // fontSize: 20,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text: "\t ₹ ${product.price!}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ksizedBoxheight20,
// row for showing the title and color of the watches
        Text(
          product.name!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        ksizedBoxheight10,
// text for description for the watch
        Text(
          product.description!,
          // maxLines: 5,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        ksizedBoxheight20,

// Row for addtoCart and Buy buttons
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Consumer<HomeProvider>(
        //       builder: (context, homeProvider, child) => GestureDetector(
        //         onTap: () => homeProvider.addToCart(product, context),
        //         child: Container(
        //             height: size.height * 0.06,
        //             width: size.width * 0.4,
        //             decoration: BoxDecoration(
        //                 color: primaryBackgroundColor,
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 searchIDForWishList(product, false) == true
        //                     ? const Icon(
        //                         Icons.done_outline_rounded,
        //                         color: Colors.white,
        //                       )
        //                     : const SizedBox(),
        //                 searchIDForWishList(product, false) == false
        //                     ? const Text(
        //                         "Add to Cart",
        //                         style: TextStyle(
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.white),
        //                       )
        //                     : const Text(
        //                         "Added",
        //                         style: TextStyle(
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.white),
        //                       )
        //               ],
        //             )),
        //       ),
        //     ),
        //     ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10)),
        //         fixedSize: Size(size.width / 2.5, 50),
        //         backgroundColor: primaryBackgroundColor,
        //         // padding: const EdgeInsets.all(15),
        //       ),
        //       onPressed: () {
        //         homeProvider.addToCart(product, context);
        //       },
        //       child: const Text(
        //         'Go to Cart',
        //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //       ),
        //     )
        //   ],
        // ),

        Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => searchIDForWishList(
                      product, false) ==
                  false
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(size.width / 2.5, 50),
                    backgroundColor: primaryBackgroundColor,
                    // padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    homeProvider.addToCart(product, context);
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(size.width / 2.5, 50),
                    backgroundColor: primaryBackgroundColor,
                    // padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScreenCart(),
                    ));
                  },
                  label: const Text(
                    'Go to Cart',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
        )
      ]),
    );
  }

  bool searchIDForWishList(Product product, bool isWisList) {
    bool findProductId = false;
    if (isWisList == true) {
      for (var i = 0; i < wishDataList.value.length; i++) {
        if (wishDataList.value[i]!.product!.id == product.id) {
          return findProductId = true;
        }
      }
    } else {
      for (var i = 0; i < cartDataList.value.length; i++) {
        if (cartDataList.value[i]!.product!.id == product.id) {
          return findProductId = true;
        }
      }
    }

    return findProductId;
  }
}
