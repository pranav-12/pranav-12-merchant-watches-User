import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/payment_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../constants/constants.dart';

// ignore: constant_identifier_names
enum PaymentMethod { cod, online_payment }

class CheckOutProvider with ChangeNotifier {
  BuildContext? context;
  Address? address;
  int? index;
  final _razorPay = Razorpay();

// For Online payment Usign RazorPay
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

// For handling the PaymentSuccess
  void _handlePaymentSuccess(
    PaymentSuccessResponse response,
  ) {
    log("PaymentType₹₹₹₹₹₹₹₹₹₹₹₹₹₹-------- ${response.paymentId}");
    Provider.of<PaymentProvider>(context!, listen: false).placeOrder(
      cartProducts: cartDataList.value,
      type: PaymentMethod.online_payment,
      context: context!,
      address: address!,
    );
    _razorPay.clear();
    notifyListeners();
  }

// For handling the PaymentFailure
  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(response.message ?? ' ')));
    _razorPay.clear();
    notifyListeners();
  }

// For handling the ExternalWallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    log(response.walletName.toString());
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(response.walletName ?? ' ')));
    _razorPay.clear();
    notifyListeners();
  }
}
