import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../appication/home/home_provider.dart';
import '../../../appication/wishlist/wishlist_provider.dart';
import '../../../constants/constants.dart';
import '../screen_show_product.dart';

class WidgetForProducts extends StatelessWidget {
  const WidgetForProducts({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: productDataList,
      builder: (context, productsList, child) {
        return SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.7,
              crossAxisCount: 2,
            ),
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              final product = productsList[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScreenShowProductDetails(
                          product: productsList[index]!, index: index),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Divider(color: primaryBackgroundColor, thickness: 1),
                          Container(
                            color: Colors.white,
                            child: Text(
                              product.name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ksizedBoxheight10,
// For showing the Rate As Cratched
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "\t ₹ ${product.price!}",
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
                                builder: (context, wishdata, child) =>
                                    GestureDetector(
                                  onTap: () async {
                                    Provider.of<WishListProvider>(context,
                                            listen: false)
                                        .addOrRemoveWishListFucn(
                                      product.id!,
                                      context,
                                    );
                                  },
                                  child: Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .searchIDForWishList(
                                                  product: product,
                                                  isWishList: true,
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
            },
          ),
        );
      },
    );
  }
}
