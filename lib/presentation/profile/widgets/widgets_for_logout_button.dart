import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../appication/bottom_nav_bar_provider.dart';
import '../../../constants/constants.dart';
import '../../../domain/models/address_model.dart';
import '../../others/splash_screen.dart';

class WidgetForLogOutBurtton extends StatelessWidget {
  const WidgetForLogOutBurtton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: Size(size.width / 2.5, 50),
          backgroundColor: Colors.white,
        ),
        onPressed: () async {
          showBottomSheet(
            backgroundColor: cartImageColor,
            enableDrag: true,
            elevation: 15,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: Column(children: [
                const Text(
                  'Do you want to Logout?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ksizedBoxheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.clear)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: IconButton(
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.remove("isSignIn");
                            if (context.mounted) return;
                            Provider.of<BottomNavBarProvider>(context,
                                    listen: false)
                                .selectedCurrentIndex = 0;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const ScreenSplash(),
                                ),
                                (route) => false);
                          },
                          icon: const Icon(Icons.check)),
                    )
                  ],
                )
              ]),
            ),
          );
        },
        child: const Text(
          'Log Out',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
