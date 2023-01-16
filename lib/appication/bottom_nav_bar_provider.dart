import 'package:flutter/cupertino.dart';

class BottomNavBarProvider with ChangeNotifier {
  int selectedCurrentIndex = 0;

  void bottomNavigationChange(int index) {
    selectedCurrentIndex = index;
    notifyListeners();
  }
}
