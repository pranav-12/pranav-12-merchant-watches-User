import 'package:flutter/cupertino.dart';

class ProductDetailsProvider with ChangeNotifier {
  List<String> imageAllvariation = [];
  int qty = 1;
  int imgList = 0;
  void addSubtractQtyFunc(bool add) {
    if (add == true) {
      qty++;
      print(qty);
      notifyListeners();
      return;
    }
    qty--;
    print(qty);
    notifyListeners();
  }

  void initState(List<String> imagevariation) {
    imageAllvariation = imagevariation;
    notifyListeners();
  }

  void changeImage(int index) {
    imgList = index;
    notifyListeners();
  }
}
