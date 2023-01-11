import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merchant_watches/presentation/others/login/screen_signin.dart';
import 'package:merchant_watches/presentation/widgets/bottom_navigation_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    getValidationData();
    super.initState();
  }

  bool isSignedIn = false;

  Future getValidationData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var obtainedUser = preferences.getBool("isSignIn");
    setState(() {
      isSignedIn = obtainedUser ?? false;
    });
    log(obtainedUser.toString());
    log(isSignedIn.toString());
  }

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
                    builder: (context) =>
                        isSignedIn == false ? ScreenSignIn() : CustomBNavBar(),
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
