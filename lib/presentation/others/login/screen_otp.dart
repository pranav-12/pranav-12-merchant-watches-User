import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_watches/appication/other/logs/login_provider.dart';
import 'package:merchant_watches/domain/models/otp_model.dart';
import 'package:merchant_watches/infrastructure/login/login_services.dart';
import 'package:merchant_watches/presentation/others/login/screen_signin.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/user_model.dart';

class ScreenOTPVerification extends StatelessWidget {
  ScreenOTPVerification({super.key, required this.email, required this.value});
  final String email;
  final Loginprovider value;

  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('OTP Verification'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Image.asset(
              "assets/2fa-authentication-password-secure-notice-login-verification-sms-with-push-code-message-shield-icon-smartphone-phone-laptop-computer-pc-flat_212005-139-removebg-preview.png"),
          Container(
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              ksizedBoxheight10,
              const Text(
                "We will send you in OTP on your mail",
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: TextField(
                  controller: otpController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp('[0-9]'), allow: true)
                  ],
                  decoration: const InputDecoration(
                      counterStyle: TextStyle(color: Colors.transparent)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Receive the OTP ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {
                      LoginServices().sendOTP(email);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                          content: Text('OTP Resended!'),
                        ),
                      );
                    },
                    child: const Text(
                      'Resend OTP',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ),
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
                onPressed: () => otpVerifyAndSignUp(context),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future<void> otpVerifyAndSignUp(BuildContext context) async {
    final otpData = OTPModel(email: email, otp: otpController.text);
    await LoginServices().verifyOTP(otpData, context);
    try {
      final signUp = FieldsForUserModel.create(
        email: value.emailController.text,
        fullname: value.fullNameController.text,
        password: value.passwordController.text,
      );

      await LoginServices.instance.signUp(signUp, value);
      value.confirmPasswordController.clear();
      value.emailController.clear();
      value.passwordController.clear();
      value.fullNameController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('SuccessFully signedUp'),
          backgroundColor: Colors.green,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenSignIn(),
      ));
    } catch (e) {
      log("otp verify:  $e");
      value.isLoadingFunc(false);
    }
  }
}
