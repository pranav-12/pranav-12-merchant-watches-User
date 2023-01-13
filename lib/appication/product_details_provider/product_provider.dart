import 'package:flutter/cupertino.dart';

class ProductDetailsProvider with ChangeNotifier {
  int qty = 1;
  int imgList = 0;
  void addSubtractQtyFunc(bool add) {
    if (add == true) {
      qty++;

      notifyListeners();
      return;
    }
    qty--;
    notifyListeners();
  }

  void changeImage(int index) {
    imgList = index;
    notifyListeners();
  }
}
