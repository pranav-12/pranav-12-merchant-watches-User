import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/address_model.dart';
import '../../../domain/models/cart_model.dart';
import '../../../domain/models/order_model.dart';
import '../../../infrastructure/others/orders/order_servises.dart';
import '../successfull_message_screen.dart';

class PaymentProvider with ChangeNotifier {
  PaymentMethod? method;

  void paymentMethodFunct(PaymentMethod type) {
    method = type;
    notifyListeners();
  }

  void placeOrder(List<ProductElement?> cartProducts, PaymentMethod type,
      BuildContext context, Address address) async {
    try {
      // String newTotalPrice = totalPrice.toString();
      // log(newTotalPrice);
      final order = OrderModel(
        addressId: address.id,
        userid: userId,
        products: cartProducts,
        paymentType: type.name.toUpperCase(),
        address: address.address,
        fullName: address.fullName,
        phone: address.phone,
        pin: address.pin,
        place: address.place,
        state: address.state,
        totalPrice: totalPrice.value,
      );
      Response? response = await OrderServices().createOrder(order);
      if (response!.statusCode == 201) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ScreenSuccessFull(),
            ),
            (route) => false);
        // ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(
        //               behavior: SnackBarBehavior.floating,
        //               backgroundColor: Colors.redAccent,
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10)),
        //               duration: const Duration(seconds: 1),
        //               content: const Text('Your product Ordered '),
        //             ),
        //           );
        // for (var i = 0; i < cartProducts.length; i++) {
        //   log("dfasgasfg" + cartProducts[i]!.product!.toString());
        //   await CartService().removeFromCart(cartProducts[i]!.product!);
        // }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
