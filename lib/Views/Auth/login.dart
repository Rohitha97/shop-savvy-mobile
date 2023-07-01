import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Views/Auth/loginTab.dart';
import 'package:shopsavvy/Views/Auth/registerTab.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

// jhgkjhg
class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color3,
        systemNavigationBarColor: color3,
        statusBarIconBrightness: Brightness.dark));

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: color6,
          appBar: AppBar(
            backgroundColor: colorPrimary,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            toolbarHeight: 0.0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Login",
                ),
                Tab(
                  text: "Register",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            LoginTab(),
            RegisterTab(),
          ]),
        ));
  }
}
