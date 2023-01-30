import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditoinsPrivacyPolicies with ChangeNotifier {
  int loadingPercentage = 0;
  
// For Show the Terms and Conditions in Web
  void initialize(String url, WebViewController  controller ) {
    controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          loadingPercentage = 0;
          notifyListeners();
        },
        onProgress: (progress) {
          loadingPercentage = progress;
          notifyListeners();
        },
        onPageFinished: (url) {
          loadingPercentage = 100;
          notifyListeners();
        },
      ))
      ..loadRequest(
        Uri.parse(url),
      );
  }
}
