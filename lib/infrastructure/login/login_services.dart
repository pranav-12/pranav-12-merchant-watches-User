import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/logs/login_provider.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/otp_model.dart';

import '../../domain/models/user_model.dart';
import '../../presentation/others/login/screen_signin.dart';
import '../../presentation/widgets/bottom_navigation_bar.dart';

class LoginServices {
  final dio = Dio();

  LoginServices.internal();
  static LoginServices instance = LoginServices.internal();

  LoginServices factory() {
    return instance;
  }

  LoginServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

  Future<void> signUp(FieldsForUserModel signUp, Loginprovider value) async {
    try {
      value.isLoadingFunc(true);
      Response response =
          await dio.post(baseUrl + authUrl + signUpUrl, data: signUp.toJson());
      if (response.statusCode == 201) {
        value.isLoadingFunc(false);
      } else {}
      log(response.statusMessage.toString());
      log('signUp done successfully');
    } on DioError catch (e) {
      log(e.response!.statusMessage!);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> sendOTP(String email) async {
    log(email);
    try {
      log("${baseUrl + authUrl + sendOTPUrl}?email=$email");
      // http://localhost:5000/auth/otp?email=pranav17472@gmail.com
      Response response =
          await dio.get("${baseUrl + authUrl + sendOTPUrl}?email=$email");
      log(response.statusCode.toString());
    } on DioError catch (e) {
      log("dioERROR--------------------" + e.message);
      // log(e.response!.statusMessage.toString());
      log(e.error);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> verifyOTP(OTPModel otp, BuildContext context) async {
    try {
      Response response =
          await dio.post(baseUrl + authUrl + sendOTPUrl, data: otp.toJson());
      if (response.statusCode == 200)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: const Text('OTP Verified SuccessFully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
    } on DioError catch (error) {
      if (error.response!.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: const Text('Invalid OTP'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> forgotPassword(
      FieldsForUserModel value, BuildContext context) async {
    log(baseUrl + authUrl + forgotPasswordUrl);
    try {
      Response response = await dio.post(baseUrl + authUrl + forgotPasswordUrl,
          data: {"email": value.email.toString(), "password": value.password});
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: const Text('Password updated successfully'),
            backgroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ScreenSignIn(),
        ));
      }
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: const Text('Invalid emailId'),
            backgroundColor: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signIn(FieldsForUserModel value, BuildContext context) async {
    // log(value.fullname.toString());
    try {
      Response response = await dio.post(baseUrl + authUrl + signInUrl, data: {
        "email": value.email.toString(),
        "password": value.password.toString()
      });
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: const Text('SignedIn Successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
      }
      log(response.statusMessage.toString());
    } on DioError catch (err) {
      log(err.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: const Text('Invalid user'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
