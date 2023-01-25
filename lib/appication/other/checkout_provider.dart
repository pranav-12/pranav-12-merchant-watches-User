// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/payment/payment_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/presentation/others/order_summary.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants/constants.dart';

enum PaymentMethod { cod, online_payment }

class CheckOutProvider with ChangeNotifier {
  BuildContext? context;
  Address? address;
  final _razorPay = Razorpay();

  void payment(BuildContext context, Address address, int price) {
    var options = {
      'key': 'rzp_test_byX4xjQdkJOyzX',
      'amount': price * 100,
      'name': 'Merchant watches',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    this.address = address;
    this.context = context;
    _razorPay.open(options);
    _razorPay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      _handlePaymentSuccess,
    );
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    notifyListeners();
  }

  void _handlePaymentSuccess(
    PaymentSuccessResponse response,
  ) {
    Provider.of<PaymentProvider>(context!, listen: false).placeOrder(
        cartDataList.value, PaymentMethod.online_payment, context!, address!);
    // Do something when payment succeeds
    ScaffoldMessenger.of(context!).showSnackBar(
      const SnackBar(
        content: Text('Payment successfully'),
      ),
    );
    _razorPay.clear();
    Navigator.of(context!).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OrderSummaryScreen(),
      ),
    );
    notifyListeners();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(response.message ?? ' ')));
    _razorPay.clear();
    notifyListeners();
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log(response.walletName.toString());
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(response.walletName ?? ' ')));
    _razorPay.clear();
    notifyListeners();
    // Do something when an external wallet was selected
  }
}
