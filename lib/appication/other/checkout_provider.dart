// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/domain/models/cart_model.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:merchant_watches/infrastructure/others/orders/order_servises.dart';

enum PaymentMethod { cod, online_payment }

class CheckOutProvider with ChangeNotifier {
  int qty = 1;

  void qtyChangeFunc(bool addButton) {
    if (addButton == true) {
      qty++;
    } else {
      qty--;
    }
    notifyListeners();
  }

 
}
