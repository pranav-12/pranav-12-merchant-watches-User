import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/appication/bottom_nav_bar_provider.dart';
import 'package:merchant_watches/appication/other/logs/login_provider.dart';
import 'package:merchant_watches/appication/product_details_provider/product_provider.dart';
import 'package:merchant_watches/presentation/others/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // final GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   mapsImplementation.useAndroidViewSurface = true;
  // }

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          
          fontFamily: GoogleFonts.righteous().fontFamily,
          primarySwatch: Colors.blue,
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
