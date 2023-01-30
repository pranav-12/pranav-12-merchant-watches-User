import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/termsandcondition_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  ScreenTermsAndConditions({super.key});

  final WebViewController controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    Provider.of<TermsAndConditoinsPrivacyPolicies>(context, listen: false)
        .initialize(
            "https://doc-hosting.flycricket.io/merchant-watches-terms-of-use/35163e87-c52e-4f22-bf6a-bdbde53770b6/terms",
            controller);
    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Terms And Conditions'),
      ),
// Body
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (Provider.of<TermsAndConditoinsPrivacyPolicies>(context,
                      listen: false)
                  .loadingPercentage <
              100)
            CircularProgressIndicator(
              value: Provider.of<TermsAndConditoinsPrivacyPolicies>(context,
                          listen: false)
                      .loadingPercentage /
                  100.0,
            )
        ],
      ),
    );
  }
}
