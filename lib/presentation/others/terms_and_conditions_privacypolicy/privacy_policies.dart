import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/termsandcondition_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicies extends StatelessWidget {
  PrivacyPolicies({super.key});
  final WebViewController controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    Provider.of<TermsAndConditoinsPrivacyPolicies>(context, listen: false)
        .initialize(
            "https://doc-hosting.flycricket.io/merchant-watches-privacy-policy/53cedc5f-f20c-4943-b656-1ebdc1d58f92/privacy",
            controller);
    return Scaffold(
// App bar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Privacy Policies'),
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
