import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/get_products_details/products_services.dart';
import 'package:merchant_watches/presentation/home/screen_show_product.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      endDrawer: Drawer(
          backgroundColor: cartImageColor,
          child: Column(
            children: [
              AppBar(
                backgroundColor: primaryBackgroundColor,
                title: Text(
                  'Merchant Watches',
                  style:
                      GoogleFonts.ultra(color: primaryFontColor, fontSize: 15),
                ),
                actions: [
                  Image.asset('assets/logo/Merchant Watches-icon.png',
                      fit: BoxFit.fill),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  // color: cartImageColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account Settings',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        ksizedBoxheight10,
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.person_solid,
                            color: primaryBackgroundColor,
                          ),
                          title: const Text('Edit Profile'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.chevron_forward),
                          ),
                        ),
                        ksizedBoxheight10,
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.location_solid,
                            color: primaryBackgroundColor,
                          ),
                          title: const Text('Saved Address'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.chevron_forward),
                          ),
                        ),
                        ksizedBoxheight10
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  // color: cartImageColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informations',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        ksizedBoxheight10,
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/setting_logo/contract.png",
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          title: const Text('Terms & Conditions'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.chevron_forward),
                          ),
                        ),
                        ksizedBoxheight10,
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/setting_logo/privacy-policy.png",
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          title: const Text('Privacy Policies'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.chevron_forward),
                          ),
                        ),
                        ksizedBoxheight10
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(size.width / 2.5, 50),
                  backgroundColor: primaryBackgroundColor,
                  // padding: const EdgeInsets.all(15),
                ),
                onPressed: () {},
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
      body: ListView(
        children: [
          ksizedBoxheight10,
          ValueListenableBuilder(
            valueListenable: productDataList,
            builder: (context, value, child) => CarouselSlider(
              items: [
                for (int i = 0; i < value.length; i++)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.fill,
                        image: NetworkImage(value[i]['image'][0]),
                      ),
                    ),
                  ),
              ],
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                animateToClosest: true,
                enlargeCenterPage: true,
              ),
            ),
          ),
          ksizedBoxheight10,
          const Text(
            'Products',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                    builder: (context) => const ScreenShowProductDetails(),
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
                                value[index]['image'][0],
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ksizedBoxheight10,
                            Divider(
                                color: primaryBackgroundColor, thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite_border))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ],
      ),
    );
  }

  void addToCart(List<dynamic> value, int index, BuildContext context) {
    // cartItems.clear();
    log(value[index]["_id"]);
    log(cartItems.toString());

    // log({cartItems[0]["_id"] == value[index]["_id"]}.toString());
    // log(cartItems.contains(value[index]['_id']).toString());

    if (cartItems.isNotEmpty) {
      for (var i = 0; i < cartItems.length; i++) {
        if (cartItems[i]["_id"] == value[index]["_id"]) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'already added in cart',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              duration: const Duration(seconds: 3),
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          cartItems.add(value[index]);
          log(cartItems.toString());
        }
      }
    }

    // if (cartItems.contains(value[index]["_id"])) {

    // }
  }
}
