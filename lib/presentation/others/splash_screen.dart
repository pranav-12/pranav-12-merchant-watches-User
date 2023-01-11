import 'package:flutter/material.dart';
import 'package:merchant_watches/presentation/others/login/screen_signin.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants/constants.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
// body
      body: TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          int percent = (value * 100).ceil();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo/Merchant Watches-Logo.png',
                  fit: BoxFit.fill),
              Text(
                'Loading...$percent',
                style: TextStyle(color: primaryFontColor),
              ),
              ksizedBoxheight10,
// linear bar
              LinearPercentIndicator(
                padding: const EdgeInsets.only(left: 50, right: 50),
                animateFromLastPercent: true,
                animation: true,
                barRadius: const Radius.circular(15),
                percent: value,
                progressColor: primaryFontColor,
                onAnimationEnd: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ScreenSignIn(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
