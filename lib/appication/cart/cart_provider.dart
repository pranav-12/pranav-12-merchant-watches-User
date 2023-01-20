import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/products_model.dart';

import '../../infrastructure/cart/cart_service.dart';

class CartProvider with ChangeNotifier {
  void totalQuantity() {
    totalQty.value = 0;
    for (var i = 0; i < cartDataList.value.length; i++) {
      totalQty.value = totalQty.value + cartDataList.value[i]!.qty!;
    }
    notifyListeners();
  }

  void removeFromCart(BuildContext context, Product cartData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        action: SnackBarAction(
          label: "Yes",
          textColor: Colors.white,
          onPressed: () async {
            await CartService().removeFromCart(cartData);
            await CartService().getDataCart(context);
          },
        ),
        content: Text(
          "Do you want to Remove From Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
  // ProductCartBaseModel? cart;

  // void cartFunc(ProductCartBaseModel val) {
  //   cart = val;
  //   notifyListeners();
  // }
}
