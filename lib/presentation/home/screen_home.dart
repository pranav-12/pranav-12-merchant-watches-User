import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/infrastructure/get_products_details/products_services.dart';
import 'package:merchant_watches/infrastructure/wishlist/wishlist_servises.dart';
import 'package:merchant_watches/presentation/home/widgets/carousel.dart';
import 'package:merchant_watches/presentation/home/widgets/widgets_for_products.dart';
import 'package:merchant_watches/presentation/widgets/loading_bar.dart';
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
// Appbar
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
// Body
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => homeProvider.loadingBool ==
                false
            ? ListView(
                children: [
                  ksizedBoxheight10,
// For Showing the Carousel
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
// For Showing the Products
                  WidgetForProducts(size: size)
                ],
              )
// For showing the Loading 
            : const LoadingWidget(),
      ),
    );
  }
}
