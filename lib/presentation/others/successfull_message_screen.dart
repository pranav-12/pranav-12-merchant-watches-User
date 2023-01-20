import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/presentation/widgets/bottom_navigation_bar.dart';
import 'package:merchant_watches/presentation/widgets/custom_button.dart';

class ScreenSuccessFull extends StatelessWidget {
  const ScreenSuccessFull({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(
      const Duration(seconds: 2),
      () => const Text('Successfully Ordered'),
    );
    return Scaffold(
        body: TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      onEnd: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => CustomBNavBar(),
          ),
          (route) => false),
      duration: const Duration(seconds: 3),
      builder: (context, value, child) {
        return Center(child: Image.asset("assets/successfully-done.gif"));
      },
    ));
  }
}
