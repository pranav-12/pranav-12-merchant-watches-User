import 'package:flutter/material.dart';
import 'package:merchant_watches/domain/models/wishlist_model.dart';

final navigatorKey = GlobalKey<NavigatorState>();

String? userId;

Color primaryFontColor = const Color.fromARGB(255, 203, 178, 106);
Color primaryBackgroundColor = Colors.black;
// 189, 195, 199
Color cartImageColor = const Color.fromARGB(255, 189, 195, 199);

const ksizedBoxheight10 = SizedBox(height: 10);
const ksizedBoxheight20 = SizedBox(height: 20);
const ksizedBoxheight50 = SizedBox(height: 50);

const ksizedBoxWidth10 = SizedBox(width: 10);
const ksizedBoxWidth20 = SizedBox(width: 20);

// const Lists

ValueNotifier<List> productDataList = ValueNotifier([]);

ValueNotifier<List> cartDataList = ValueNotifier([]);

// ValueNotifier<List<ProductElement>> wishDataList = ValueNotifier([]);
ValueNotifier<List<WishListModel>> wishDataList = ValueNotifier([]);
