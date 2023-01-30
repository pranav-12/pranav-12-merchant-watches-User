import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('About Us'),
      ),
// Body
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Developed by Pranav Nandhan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Supported by BroCamp',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Join our team :spsonline.in',
              style: TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
