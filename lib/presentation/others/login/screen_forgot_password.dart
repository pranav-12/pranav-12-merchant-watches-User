import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/login_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:provider/provider.dart';

class ScreenForgotPassword extends StatelessWidget {
  const ScreenForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Reset Password'),
      ),
// Body
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Loginprovider>(
          builder: (context, logInProv, child) => Form(
            key: logInProv.formkeyForForgotPass,
            child: Column(
              children: [
// TextFormField For  Email
                TextFormField(
                  controller: logInProv.emailControllerForgotPass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter your mail'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter mail';
                    }
                    return null;
                  },
                ),
                ksizedBoxheight20,
// TextFormField For  new Password
                TextFormField(
                  controller: logInProv.newPasswordControllerForgotPass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'new Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter new password';
                    }
                    return null;
                  },
                ),
                ksizedBoxheight20,
// TextFormField For Confirm Password
                TextFormField(
                  controller: logInProv.confirmPasswordControllerForgotPass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter confirmPassword';
                    } else if (logInProv.newPasswordControllerForgotPass.text !=
                        logInProv.confirmPasswordControllerForgotPass.text) {
                      return 'Does not Match newPassword and confirm Password';
                    }
                    return null;
                  },
                ),
                ksizedBoxheight20,
// Elevated Button For Save the Abouve Details
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBackgroundColor,
                    elevation: 5,
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => logInProv.savePassword(context),
                  child: const Text(
                    'Save ',
                    style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
