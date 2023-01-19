import 'package:flutter/cupertino.dart';

class CheckOutProvider with ChangeNotifier {
  int qty = 1;

  void qtyChangeFunc(bool addButton) {
    if (addButton == true) {
      qty++;
    } else {
      qty--;
    }
    notifyListeners();
  }
}
