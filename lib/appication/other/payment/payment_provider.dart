// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/checkout_provider.dart';
import 'package:merchant_watches/infrastructure/cart/cart_service.dart';
import 'package:merchant_watches/presentation/others/orders/order_summary.dart';
import 'package:merchant_watches/presentation/others/successfull_message_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/address_model.dart';
import '../../../domain/models/cart_model.dart';
import '../../../domain/models/order_model.dart';
import '../../../infrastructure/others/orders/order_servises.dart';
import '../orders/orders_provider.dart';

class PaymentProvider with ChangeNotifier {
  
  // void paymentMethodFunct(PaymentMethod type) {
  //   method = type;
  //   notifyListeners();
  // }

  void placeOrder(
      {required List<ProductElement?> cartProducts,
      required PaymentMethod type,
      required BuildContext context,
      required Address address,
      }) async {
    try {
      // String newTotalPrice = totalPrice.toString();
      // log(newTotalPrice);
      final order = Order(
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
      await OrderServices().getOrders(context);
      if (response!.statusCode == 201) {
        if (type == PaymentMethod.cod) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ScreenSuccessFull(),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenOrderSummary(
                    order: Provider.of<OrderProvider>(context)
                        .orders!
                        .orders!
                        .last,
                    isNavigatedbysuccessFullScreen: true,
                    
                  )));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
