import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopsavvy/Controllers/Common/HttpController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Utils/APIRoutes.dart';
import 'package:shopsavvy/Models/Utils/JsonResponse.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';

class RegisterController {
  final HttpController _httpController = HttpController();

  Future<bool> register(context, Map<String, dynamic> data) async {
    CustomUtils.showLoader(context);
    bool httpStatus = false;
    await _httpController
        .doPost(APIRoutes.getRoute('REGISTER'), {}, data)
        .then((Response response) {
      CustomUtils.hideLoader(context);

      var resp = JsonResponse.fromJson(response.data);

      if (resp.statusCode == 200) {
        CustomUtils.showSnackBar(
            context, "Registration Complete", CustomUtils.SUCCESS_SNACKBAR);
        httpStatus = true;
      } else {
        CustomUtils.showSnackBarList(
            context, resp.data, CustomUtils.ERROR_SNACKBAR);
      }
    });
    return httpStatus;
  }
}
