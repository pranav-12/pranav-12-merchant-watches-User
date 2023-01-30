import 'package:flutter/cupertino.dart';

class ProductDetailsProvider with ChangeNotifier {
  int imgList = 0;

// For changing the Image that Assign the Value Of imageList
  void changeImage(int index) {
    imgList = index;
    notifyListeners();
  }
}
