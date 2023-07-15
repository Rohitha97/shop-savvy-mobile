import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopsavvy/Controllers/Common/HttpController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Utils/APIRoutes.dart';
import 'package:shopsavvy/Models/Utils/JsonResponse.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Views/Auth/login.dart';
import 'package:shopsavvy/Views/Dashboard/dashboard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  final HttpController _httpController = HttpController();
  final storage = new FlutterSecureStorage();

  Future<void> commonLogin(context, Map<String, dynamic> data) async {
    CustomUtils.showLoader(context);
    await _httpController
        .doPost(APIRoutes.getRoute('LOGIN'), {}, data)
        .then((Response response) async {
      CustomUtils.hideLoader(context);

      var resp = JsonResponse.fromJson(response.data);
      if (resp.statusCode == 200) {
        await User.saveUser(resp);
        await storage.write(
            key: 'access_token', value: resp.data['access_token']);

        // Save user data to storage
        await storage.write(key: 'user', value: json.encode(resp.data['user']));
        Routes(context: context).navigateReplace(Dashboard());
      } else if (resp.statusCode == 422) {
        CustomUtils.showSnackBarMessage(
            context, resp.data, CustomUtils.ERROR_SNACKBAR);
      } else {
        CustomUtils.showSnackBarList(
            context, resp.data, CustomUtils.ERROR_SNACKBAR);
      }
    });
  }

  Future<bool> verifyUser() async {
    bool httpStatus = false;
    try {
      String? accessToken = await storage.read(key: 'access_token');
      print('Access token: $accessToken');
      if (accessToken != null) {
        User storedUser = await User.getUser();
        print('User ID: ${storedUser.id}, User Status: ${storedUser.status}');
        if (storedUser.id != 0) {
          if (int.parse(storedUser.status) == 1) {
            httpStatus = true;
          } else {
            httpStatus = false;
          }
        } else {
          httpStatus = false;
        }
      }
    } catch (e) {
      print(e.toString());
    }

    print('HTTP Status: $httpStatus');
    return httpStatus;
  }

  Future<void> logout(context) async {
    await User.logout();
    // Delete the access_token from storage
    await storage.delete(key: 'access_token');
    Routes(context: context).navigateReplace(const Login());
  }
}
