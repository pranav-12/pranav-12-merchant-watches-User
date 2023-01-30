import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/otp_model.dart';
import '../../domain/models/user_model.dart';
import '../../infrastructure/others/login/login_services.dart';
import '../../presentation/others/login/screen_otp.dart';
import '../../presentation/others/login/screen_signin.dart';
import '../home/home_provider.dart';

class Loginprovider with ChangeNotifier {
  bool isLoading = false;
  bool visible = true;
// These Fields For SignUp
  final formKeyForSignUp = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

// These Fields For Forgot Password
  final formkeyForForgotPass = GlobalKey<FormState>();
  final emailControllerForgotPass = TextEditingController();
  final newPasswordControllerForgotPass = TextEditingController();
  final confirmPasswordControllerForgotPass = TextEditingController();

// These Variables For Otp Verification
  final otpController = TextEditingController();

// These Fields For SignIn
  final forkeyForSignIn = GlobalKey<FormState>();
  final mailIdControllerForSignIn = TextEditingController();
  final passwordControllerForSignIn = TextEditingController();

  // For signIn hide the Password
  void visibleONOrOf(bool val) {
    visible = val;
    notifyListeners();
  }

  // For Submit the Data's For Forgot PasWord
  void savePassword(BuildContext context) async {
    if (emailControllerForgotPass.text.isEmpty &&
        newPasswordControllerForgotPass.text.isEmpty &&
        confirmPasswordControllerForgotPass.text.isEmpty) {
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
              email: emailControllerForgotPass.text,
              password: newPasswordControllerForgotPass.text);
          LoginServices().forgotPassword(context, forgotPass);

          Navigator.of(context).pop();
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }

// For Verify Otp
  Future<void> otpVerifyAndSignUp(BuildContext context, String email) async {
    final otpData = OTPModel(email: email, otp: otpController.text);
    await LoginServices().verifyOTP(otpData, context);
    try {
      final signUp = FieldsForUserModel.create(
        email: emailController.text,
        fullname: fullNameController.text,
        password: passwordController.text,
      );
      if (context.mounted) return;
      await LoginServices.instance.signUp(signUp, context);
      confirmPasswordController.clear();
      emailController.clear();
      passwordController.clear();
      fullNameController.clear();
      if (context.mounted) return;
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
      if (context.mounted) return;
      Provider.of<HomeProvider>(context, listen: false).loading(false);
    }
  }

// For SignIn
  Future<void> signInButton(
    BuildContext context,
  ) async {
    if (mailIdControllerForSignIn.text.isEmpty &&
        passwordController.text.isEmpty) {
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
              email: mailIdControllerForSignIn.text,
              password: passwordController.text);
          await LoginServices().signIn(signIn, context);
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }

// For SignUp

  void signUpButton(BuildContext context,) async {
    if (fullNameController.text.isEmpty &&
        emailController.text.isEmpty &&
        passwordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty) {
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
      if (formKeyForSignUp.currentState!.validate()) {
        try {
          LoginServices().sendOTP(emailController.text);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenOTPVerification(
                email: emailController.text,
              ),
            ),
          );
        } catch (e) {
          log("signUpButton: $e");
          Provider.of<HomeProvider>(context).loading(false);
        }
      }
    }
  }
}
