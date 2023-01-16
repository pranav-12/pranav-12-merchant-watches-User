import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_watches/appication/other/logs/login_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/login/login_services.dart';
import 'package:merchant_watches/presentation/others/login/screen_otp.dart';
import 'package:merchant_watches/presentation/others/login/screen_signin.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<Loginprovider>(
            builder: (context, value, child) => value.isLoading == false
                ? Form(
                    key: value.formKeyForSignUp,
                    child:
                        ListView(padding: const EdgeInsets.all(10), children: [
                      const Text(
                        'SignUp',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      ksizedBoxheight20,
                      TextFormField(
                        controller: value.fullNameController,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[a-z, ,A-Z]"),
                              allow: true)
                        ],
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'full name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name is empty';
                          } else if (value.length < 5) {
                            return 'name must have 5 letters';
                          }
                          return null;
                        },
                      ),
                      ksizedBoxheight20,
                      TextFormField(
                        controller: value.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value1) {
                          if (value1!.isEmpty) {
                            return 'email is empty';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.emailController.text)) {
                            return 'Check your email';
                          }
                          // return null;
                          return null;
                        },
                      ),
                      ksizedBoxheight20,
                      TextFormField(
                        controller: value.passwordController,
                        autocorrect: true,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[a-z,0-9,A-Z]"),
                              allow: true)
                        ],
                        // keyboardType: ,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Password ',
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
                      ksizedBoxheight20,
                      TextFormField(
                        controller: value.confirmPasswordController,
                        autocorrect: true,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[a-z,0-9,A-Z]"),
                              allow: true)
                        ],
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value1) {
                          if (value1!.isEmpty) {
                            return 'confirmPassword is empty';
                          } else if (value.passwordController.text !=
                              value.confirmPasswordController.text) {
                            return 'Password and confirmpassword does not match';
                          }
                          return null;
                        },
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => signUpButton(context, value),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => ScreenSignIn(),
                            )),
                            child: const Text(
                              'SignIn',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ],
                      )
                    ]),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: primaryBackgroundColor,
                      color: primaryFontColor,
                    ),
                  )),
      ),
    );
  }

  void signUpButton(BuildContext context, Loginprovider value) async {
    if (value.fullNameController.text.isEmpty &&
        value.emailController.text.isEmpty &&
        value.passwordController.text.isEmpty &&
        value.confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid SignUp Details'),
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      if (value.formKeyForSignUp.currentState!.validate()) {
        try {
          // Response? response = await LoginServices.instance
          //     .checkUser(value.emailController.text);

          // if (response!.statusCode == 200) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: const Text('User already exist'),
          //       backgroundColor: Colors.red,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15),),
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );
          //   return;
          // }
        
          log("message");
          LoginServices().sendOTP(value.emailController.text);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenOTPVerification(
                  email: value.emailController.text, value: value),
            ),
          );
        } catch (e) {
          log("signUpButton: $e");
          value.isLoadingFunc(false);
        }
      }
    }
  }
}
