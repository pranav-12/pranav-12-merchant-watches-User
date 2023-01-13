import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  int qty = 1;
  int? totalAmount;
}
