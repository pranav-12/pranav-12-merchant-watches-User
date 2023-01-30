import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/presentation/others/login/screen_forgot_password.dart';
import 'package:merchant_watches/presentation/others/login/screen_signup.dart';
import 'package:provider/provider.dart';
import '../../../appication/other/login_provider.dart';

class ScreenSignIn extends StatelessWidget {
  const ScreenSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Body
      body: SafeArea(
        child: Consumer<Loginprovider>(
          builder: (context, loginProv, child) => Form(
            key: loginProv.forkeyForSignIn,
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
// TextFormField For Email
                TextFormField(
                  controller: loginProv.mailIdControllerForSignIn,
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
                        .hasMatch(loginProv.mailIdControllerForSignIn.text)) {
                      return 'Check your email';
                    }
                    // return null;
                    return null;
                  },
                ),
                ksizedBoxheight20,
// TextFormField For Password
                TextFormField(
                  controller: loginProv.passwordControllerForSignIn,
                  autocorrect: true,
                  obscureText: loginProv.visible,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginProv.visible == true
                            ? loginProv.visibleONOrOf(false)
                            : loginProv.visibleONOrOf(true);
                      },
                      icon: loginProv.visible == true
                          ? const Icon(
                              CupertinoIcons.eye_slash_fill,
                              color: Colors.black,
                            )
                          : const Icon(
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

// TextButton For ForgotPassWord
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScreenForgotPassword(),
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
// Elevatedbutton For Submit the Email and Password
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
                    onPressed: () =>
                        Provider.of<Loginprovider>(context, listen: false)
                            .signInButton(
                      context,
                    ),
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
// Row Contains Text message and Textbutton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenSignUp(),
                        ),
                      ),
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
