import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Strings/common.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Views/PopUps/Confirmation.dart';
import 'package:shopsavvy/Views/PopUps/Loading.dart';
import 'package:shopsavvy/Views/Widgets/custom_button.dart';

class CustomUtils {
  static const int DEFAULT_SNACKBAR = 1;
  static const int SUCCESS_SNACKBAR = 2;
  static const int ERROR_SNACKBAR = 3;

  static late String loggedInToken;
  static User? loggedInUser;

  static Map<int, Color> tabViewColor = {
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

  static getToken() {
    return utf8.decode(base64.decode(loggedInToken));
  }

  static getBearerToken() {
    String token = utf8.decode(base64.decode(loggedInToken));
    return 'Bearer $token';
  }

  static setLoggedToken(token) {
    loggedInToken = base64.encode(utf8.encode(token));
    return loggedInToken;
  }

  static User? getUser() {
    return loggedInUser;
  }

  static setLoggedUser(jsonData) async {
    loggedInUser = User.fromJson(jsonData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(loggedInUser!.toJson()));
    return loggedInUser;
  }

  static Future showLoader(context) async {
    showDialog(
      context: context,
      builder: (_) => Loading(),
    );
  }

  static Future<bool> confirmationAction(context, title, message) async {
    return await showDialog(
          context: context,
          builder: (_) => Confirmation(title: title, message: message),
        ) ??
        false;
  }

  static Future hideLoader(context) async {
    Navigator.pop(context);
  }

  static String formatDate(DateTime date) {
    return DateFormat("yyyy/MM/dd").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("hh:mm a").format(date);
  }

  static showSnackBar(context, message, int type) {
    Color backgroundColor = color6;
    Color textColor = color8;
    print(type);
    switch (type) {
      case 1:
        backgroundColor = color6;
        textColor = color8;
        break;
      case 2:
        backgroundColor = color3;
        textColor = color6;
        break;
      case 3:
        backgroundColor = color3;
        textColor = color6;
        break;
      default:
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(fontFamily: 'Raleway-SemiBold', color: textColor),
      ),
    ));
  }

  static Future<bool> showConfirmation(context, description, title) async {
    bool returnAction = false;

    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Raleway-SemiBold'),
                ),
                (description != null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          description,
                          style: const TextStyle(
                              fontSize: 15.0, fontFamily: 'Raleway-Regular'),
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: CustomButton(
                              buttonText: Confirm_text,
                              textColor: color6,
                              backgroundColor: color3,
                              isBorder: false,
                              borderColor: color6,
                              onclickFunction: () async {
                                returnAction = true;
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: CustomButton(
                                buttonText: Decline_text,
                                textColor: color3,
                                backgroundColor: color6,
                                isBorder: true,
                                borderColor: color3,
                                onclickFunction: () async {
                                  returnAction = false;
                                  Navigator.pop(context);
                                }),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        });

    return returnAction;
  }

  static showSnackBarList(context, contents, int type) {
    Color backgroundColor = color6;
    Color textColor = color8;

    switch (type) {
      case 1:
        backgroundColor = color6;
        textColor = color8;
        break;
      case 2:
        backgroundColor = color3;
        textColor = color6;
        break;
      case 3:
        backgroundColor = color6;
        textColor = color8;
        break;
      default:
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Wrap(
        children: [
          for (String message in contents)
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                message,
                style:
                    TextStyle(fontFamily: 'Raleway-SemiBold', color: textColor),
              ),
            ),
        ],
      ),
    ));
  }

  static showSnackBarMessage(context, contents, int type) {
    Color backgroundColor = color6;
    Color textColor = color8;
    switch (type) {
      case 1:
        backgroundColor = color6;
        textColor = color8;
        break;
      case 2:
        backgroundColor = color3;
        textColor = color6;
        break;
      case ERROR_SNACKBAR:
        backgroundColor = color12;
        textColor = color9;
        break;
      default:
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          contents,
          style: TextStyle(fontFamily: 'Raleway-SemiBold', color: textColor),
        ),
      ),
    ));
  }
}
