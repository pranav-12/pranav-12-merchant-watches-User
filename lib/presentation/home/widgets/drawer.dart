import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_watches/presentation/others/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';

class DrawerDesign extends StatelessWidget {
  const DrawerDesign({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: cartImageColor,
        child: Column(
          children: [
            AppBar(
              backgroundColor: primaryBackgroundColor,
              title: Text(
                'Merchant Watches',
                style: GoogleFonts.ultra(color: primaryFontColor, fontSize: 15),
              ),
              actions: [
                Image.asset('assets/logo/Merchant Watches-icon.png',
                    fit: BoxFit.fill),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                // color: cartImageColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Settings',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      ksizedBoxheight10,
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.person_solid,
                          color: primaryBackgroundColor,
                        ),
                        title: const Text('Edit Profile'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ),
                      ksizedBoxheight10,
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.location_solid,
                          color: primaryBackgroundColor,
                        ),
                        title: const Text('Saved Address'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ),
                      ksizedBoxheight10
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                // color: cartImageColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informations',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      ksizedBoxheight10,
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/setting_logo/contract.png",
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        title: const Text('Terms & Conditions'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ),
                      ksizedBoxheight10,
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/setting_logo/privacy-policy.png",
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        title: const Text('Privacy Policies'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ),
                      ksizedBoxheight10
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(size.width / 2.5, 50),
                backgroundColor: primaryBackgroundColor,
                // padding: const EdgeInsets.all(15),
              ),
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove("isSignIn");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const ScreenSplash(),
                    ),
                    (route) => false);
              },
              child: const Text(
                'Log Out',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }
}
