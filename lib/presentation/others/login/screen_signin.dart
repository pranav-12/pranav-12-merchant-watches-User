import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/user_model.dart';
import 'package:merchant_watches/infrastructure/others/login/login_services.dart';
import 'package:merchant_watches/presentation/others/login/screen_forgot_password.dart';
import 'package:merchant_watches/presentation/others/login/screen_signup.dart';
import 'package:merchant_watches/presentation/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../appication/home/home_provider.dart';

class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({super.key});
  final forkeyForSignIn = GlobalKey<FormState>();
  final mailIdController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // log("sign in page: $validUser");pran
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: forkeyForSignIn,
          child: ListView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  right: 10,
                  left: 10),
              children: [
                const Text(
                  'SignIn',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                ksizedBoxheight20,
                const Text(
                  'Please sign in to continue',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                ksizedBoxheight20,
                TextFormField(
                  controller: mailIdController,
                  autocorrect: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'email ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value1) {
                    if (value1!.isEmpty) {
                      return 'email is empty';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(mailIdController.text)) {
                      return 'Check your email';
                    }
                    // return null;
                    return null;
                  },
                ),
                ksizedBoxheight20,
                Consumer<HomeProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: passwordController,
                    autocorrect: true,
                    obscureText: value.visible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.visible == true
                              ? value.visibleONOrOf(false)
                              : value.visibleONOrOf(true);
                        },
                        icon: value.visible == true
                            ? Icon(
                                CupertinoIcons.eye_slash_fill,
                                color: Colors.black,
                              )
                            : Icon(
                                CupertinoIcons.eye,
                                color: Colors.black,
                              ),
                      ),
                      hintText: 'password ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password is empty';
                      } else if (value.length < 5) {
                        return 'passwords must have 5 letters';
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenForgotPassword(),
                      ),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                ksizedBoxheight50,
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBackgroundColor,
                        elevation: 5,
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => signInButton(
                      context,
                    ),
                    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                    // builder: (context) => signInButton(context),
                    //  CustomBNavBar(),

                    // ),
                    // ),
                    child: const Text(
                      'SignIn',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScreenSignUp(),
                      )),
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }

  Future<void> signInButton(
    BuildContext context,
  ) async {
    if (mailIdController.text.isEmpty && passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: const Text('Mailid and Password is empty'),
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // log(forkeyForSignIn.currentState!.validate().toString());
      if (forkeyForSignIn.currentState!.validate()) {
        try {
          final signIn = FieldsForUserModel(
              email: mailIdController.text, password: passwordController.text);
          await LoginServices().signIn(signIn, context);
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }
}
