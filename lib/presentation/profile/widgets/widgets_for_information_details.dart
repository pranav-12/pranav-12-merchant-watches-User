import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../others/terms_and_conditions_privacypolicy/about_us/aboutus.dart';
import '../../others/terms_and_conditions_privacypolicy/privacy_policies.dart';
import '../../others/terms_and_conditions_privacypolicy/terms_and_conditions.dart';

class WidgetForInformation extends StatelessWidget {
  const WidgetForInformation({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informations',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
// LIsttile for Terms and conditions
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/setting_logo/contract.png",
                ),
                backgroundColor: Colors.transparent,
              ),
              title: const Text('Terms & Conditions'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScreenTermsAndConditions(),
                    ),
                  );
                },
                icon: const Icon(CupertinoIcons.chevron_forward),
              ),
            ),
// LIsttile for Privacy Policy
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/setting_logo/privacy-policy.png",
                ),
                backgroundColor: Colors.transparent,
              ),
              title: const Text('Privacy Policies'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicies(),
                    ),
                  );
                },
                icon: const Icon(CupertinoIcons.chevron_forward),
              ),
            ),
// LIsttile for About Us
            ListTile(
              leading: Icon(
                Icons.info,
                size: 40,
                color: primaryBackgroundColor,
              ),
              title: const Text('About Us'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScreenAboutUs(),
                    ),
                  );
                },
                icon: const Icon(CupertinoIcons.chevron_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
