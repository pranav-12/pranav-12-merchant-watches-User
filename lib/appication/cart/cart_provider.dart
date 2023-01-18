import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/constants/constants.dart';

class CartProvider with ChangeNotifier {
  void totalQuantity() {
    totalQty.value = 0;
    for (var i = 0; i < cartDataList.value.length; i++) {
      totalQty.value = totalQty.value + cartDataList.value[i]!.qty!;
    }
    notifyListeners();
  }
  // ProductCartBaseModel? cart;

  // void cartFunc(ProductCartBaseModel val) {
  //   cart = val;
  //   notifyListeners();
  // }
}
