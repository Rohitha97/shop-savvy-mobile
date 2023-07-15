import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopsavvy/Controllers/Auth/LoginController.dart';
import 'package:shopsavvy/Models/Strings/splash_screen.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Images.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Views/Auth/login.dart';
import 'package:shopsavvy/Views/Dashboard/dashboard.dart';

import '../../Models/DB/User.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController _loginController = LoginController();

  late Timer _timer;
  bool isTimerInitialized = false;

  @override
  void initState() {
    super.initState();

    startApp();
  }

  @override
  void dispose() {
    if (isTimerInitialized) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color6,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: displaySize.width * 0.5,
                child: Image.asset(logo),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(SplashScreen_bottom_text_1.toUpperCase()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      SplashScreen_bottom_text_2.toUpperCase(),
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startApp() async {
    // Add your token check method here
    bool isLoggedIn = await _loginController.verifyUser();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      isTimerInitialized = true;
      _timer.cancel();
      print("is logged in: $isLoggedIn");

      if (isLoggedIn) {
        // If user is already logged in, navigate to the main part of the app
        Routes(context: context).navigateReplace(Dashboard());
      } else {
        // If user is not logged in, navigate to the login screen
        Routes(context: context).navigateReplace(const Login());
      }
    });
  }
}
