import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/user_model.dart';
import 'package:merchant_watches/infrastructure/login/login_services.dart';

class ScreenForgotPassword extends StatelessWidget {
  ScreenForgotPassword({super.key});
  final formkeyForForgotPass = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkeyForForgotPass,
          child: Column(children: [
            TextFormField(
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'enter your mail'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'enter mail';
                }
                return null;
              },
            ),
            ksizedBoxheight20,
            TextFormField(
              controller: newPasswordController,
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
            TextFormField(
              controller: confirmPasswordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'confirm Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'enter confirmPassword';
                } else if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  return 'Does not Match newPassword and confirm Password';
                }
                return null;
              },
            ),
            ksizedBoxheight20,
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
              onPressed: () => savePassword(context),
              child: const Text(
                'Save ',
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void savePassword(BuildContext context) async {
    if (emailController.text.isEmpty &&
        newPasswordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid Details'),
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      if (formkeyForForgotPass.currentState!.validate()) {
        try {
          final forgotPass = FieldsForUserModel(
              email: emailController.text,
              password: newPasswordController.text);
          LoginServices().forgotPassword(forgotPass);

          Navigator.of(context).pop();
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }
}
