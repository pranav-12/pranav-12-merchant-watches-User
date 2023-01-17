import 'package:flutter/cupertino.dart';

import '../../domain/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  int qty = 1;
  int? totalAmount;
  // ProductCartBaseModel? cart;

  // void cartFunc(ProductCartBaseModel val) {
  //   cart = val;
  //   notifyListeners();
  // }
}
