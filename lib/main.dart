import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsavvy/Models/Strings/common.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Views/Init/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color3,
        systemNavigationBarColor: color3,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        fontFamily: 'Raleway-Medium',
        primarySwatch: MaterialColor(0xFF030303, color),
        unselectedWidgetColor: color7,
      ),
      home: const SplashScreen(),
    );
  }

  Map<int, Color> color = {
    50: color1,
    100: color1,
    200: color1,
    300: color1,
    400: color1,
    500: color1,
    600: color1,
    700: color1,
    800: color1,
    900: color1,
  };
}
