import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../domain/models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  WishListModel? data;

  void assignData(WishListModel val) {
    data = val;
    log(data.toString());
    log(val.toString());
    notifyListeners();
  }
}
