import 'package:flutter/cupertino.dart';
import 'package:merchant_watches/infrastructure/others/address/address_servises.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  String email = '';

// For set the value From SharedPreference and call the Get All Address Data From Api's
  void sharedpreferen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString("email")!;
    await AddressServices().getAllAddress();
    notifyListeners();
  }
}
