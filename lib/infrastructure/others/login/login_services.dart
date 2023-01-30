import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/core/url.dart';
import 'package:merchant_watches/domain/models/otp_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/user_model.dart';
import '../../../presentation/widgets/bottom_navigation_bar.dart';

class LoginServices {
  final dio = Dio();

  LoginServices.internal();
  static LoginServices instance = LoginServices.internal();

  LoginServices factory() {
    return instance;
  }

  //
  LoginServices() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }

// For SignUp Data's Send to the BackEnd
  Future<void> signUp(FieldsForUserModel signUp, context) async {
    try {
      Provider.of<HomeProvider>(context, listen: false).loading(true);
      Response response =
          await dio.post(authUrl + signUpUrl, data: signUp.toJson());
      if (response.statusCode == 201) {
        Provider.of<HomeProvider>(context, listen: false).loading(false);
      } else {}
      log(response.statusMessage.toString());
      log('signUp done successfully');
    } on DioError catch (e) {
      log(e.response!.statusMessage!);
    } catch (e) {
      log(e.toString());
    }
  }

// For SendOtp Through Api's
  Future<void> sendOTP(String email) async {
    log(email);
    try {
      log("${baseUrl + authUrl + sendOTPUrl}?email=$email");
      // http://localhost:5000/auth/otp?email=pranav17472@gmail.com
      Response response = await dio.get("${authUrl + sendOTPUrl}?email=$email");
      log(response.statusCode.toString());
    } on DioError catch (e) {
      log("dioERROR--------------------${e.message}");
      // log(e.response!.statusMessage.toString());
      log(e.error);
    } catch (e) {
      log(e.toString());
    }
  }

// For Verify the Otp and Returns the Responce
  Future<void> verifyOTP(OTPModel otp, context) async {
    try {
      Response response =
          await dio.post(authUrl + sendOTPUrl, data: otp.toJson());
      if (response.statusCode == 200) {
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
      }
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

// For Forgot Password  Data's Send to the Api's
  Future<void> forgotPassword(
    context,
    FieldsForUserModel value,
  ) async {
    log(baseUrl + authUrl + forgotPasswordUrl);
    try {
      Response response = await dio.post(authUrl + forgotPasswordUrl,
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
        Navigator.of(context).pop();
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

// For signIn  Data's Send to the Api's
  Future<void> signIn(FieldsForUserModel value, context) async {
    try {
      Response response = await dio.post(authUrl + signInUrl, data: {
        "email": value.email.toString(),
        "password": value.password.toString()
      });
      log("res: =====${response.statusCode}");
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("isSignIn", true);
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
        checkUser(value.email.toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CustomBNavBar(),
        ));
      }
    } on DioError catch (err) {
      log("dioError-====-====-====${err.response!.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(err.toString()),
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

// For Checking the User From BackEnd
  Future<Response?> checkUser(String userEmail) async {
    log(userEmail);
    try {
      Response response = await dio.get("/users/?email=$userEmail");
      final user = FieldsForUserModel.fromJson(jsonDecode(response.data));
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("UserId", user.id!);
      sharedPreferences.setString("email", user.email!);
      log(sharedPreferences.toString());
      return response;
    } on DioError catch (err) {
      log("checkuser in Dio :----${err.response}");
      return err.response;
    } catch (e) {
      log('error on checkUser :====$e');
      return null;
    }
  }
}
