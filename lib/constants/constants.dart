import 'package:flutter/material.dart';
import 'package:merchant_watches/domain/models/address_model.dart';

import '../domain/models/cart_model.dart';
import '../domain/models/products_model.dart';
import '../domain/models/wishlist_model.dart';

String? userId;

Color primaryFontColor = const Color.fromARGB(255, 203, 178, 106);
Color primaryBackgroundColor = Colors.black;
Color cartImageColor = const Color.fromARGB(255, 189, 195, 199);

// For Height
const ksizedBoxheight10 = SizedBox(height: 10);
const ksizedBoxheight20 = SizedBox(height: 20);
const ksizedBoxheight50 = SizedBox(height: 50);

// For Width
const ksizedBoxWidth10 = SizedBox(width: 10);
const ksizedBoxWidth5 = SizedBox(width: 5);
const ksizedBoxWidth20 = SizedBox(width: 20);

// const Variables
ValueNotifier<int> totalPrice = ValueNotifier(0);
ValueNotifier<int> totalQty = ValueNotifier(0);

// const Lists
ValueNotifier<List<Product?>> productDataList = ValueNotifier([]);
ValueNotifier<List<Address?>> addressDataList = ValueNotifier([]);
ValueNotifier<List<ProductElement?>> cartDataList = ValueNotifier([]);
ValueNotifier<List<ProductElementForWishList?>> wishDataList =
    ValueNotifier([]);
