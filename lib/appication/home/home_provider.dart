import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/constants/constants.dart';


class HomeProvider with ChangeNotifier {
  List addToCartList = [];

  void addOrRemoveCartFucn(bool click, int index) {
    if (click == true) {
      addToCartList.remove(productDataList.value[index]);
      notifyListeners();
      return;
    }
    addToCartList.add(productDataList.value[index]);
    notifyListeners();
  }

  void addUserId(String id) {
    userId = id;
    log('userIDProvider========$userId');
    notifyListeners();
  }
}
