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
    showBottomSheet(
      backgroundColor: cartImageColor,
      enableDrag: true,
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Column(children: [
          const Text(
            'Do you want to delete?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ksizedBoxheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.clear)),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: IconButton(
                    onPressed: () async {
                      await CartService().removeFromCart(cartData);
                      await CartService().getDataCart(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          content: const Text(
                            "Product deleted Successfully",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check)),
              )
            ],
          )
        ]),
      ),
    );
  }
  // ProductCartBaseModel? cart;

  // void cartFunc(ProductCartBaseModel val) {
  //   cart = val;
  //   notifyListeners();
  // }
}
