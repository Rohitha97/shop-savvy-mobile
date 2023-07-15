import 'dart:convert';

import 'package:shopsavvy/Models/Utils/JsonResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Utils.dart';

class User {
  var id, status, usertype, name, email;

  User(this.id, this.status, this.usertype, this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        name = json['name'],
        usertype = json['usertype'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'status': this.status,
      'usertype': this.usertype,
      'name': this.name,
      'email': this.email,
    };
  }

  static saveToken(JsonResponse resp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomUtils.setLoggedToken(resp.data["token"]);
    await prefs.setString("token", CustomUtils.getToken());
    await prefs.setBool("bio", false);
  }

  static Future getSavedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<void> saveUser(JsonResponse resp) async {
    print(resp.data["user"]);
    CustomUtils.setLoggedUser(resp.data["user"]);
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    print('get dat $userString');
    if (userString != null) {
      Map<String, dynamic> userMap =
          Map<String, dynamic>.from(jsonDecode(userString));
      return User.fromJson(userMap);
    }
    throw Exception('No user data found');
  }
}
