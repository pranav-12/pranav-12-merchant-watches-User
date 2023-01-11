import 'package:flutter/cupertino.dart';

class Loginprovider with ChangeNotifier {
  bool isLoading = false;
   final formKeyForSignUp = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void isLoadingFunc(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
