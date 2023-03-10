import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/appication/bottom_nav_bar_provider.dart';
import 'package:merchant_watches/appication/cart/cart_provider.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/appication/other/address_provider.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/appication/other/login_provider.dart';
import 'package:merchant_watches/appication/other/orders_provider.dart';
import 'package:merchant_watches/appication/other/termsandcondition_provider.dart';
import 'package:merchant_watches/appication/product_details_provider/product_provider.dart';
import 'package:merchant_watches/appication/profile/profile_provider.dart';
import 'package:merchant_watches/appication/wishlist/wishlist_provider.dart';
import 'package:merchant_watches/appication/other/payment_provider.dart';
import 'package:merchant_watches/presentation/others/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Loginprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckOutProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => TermsAndConditoinsPrivacyPolicies(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts.kanit().fontFamily,
          primarySwatch: Colors.blue,
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
