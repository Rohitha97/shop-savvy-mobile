import 'package:dio/dio.dart';
import 'package:shopsavvy/Controllers/Common/HttpController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Utils/APIRoutes.dart';
import 'package:shopsavvy/Models/Utils/JsonResponse.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Views/Auth/login.dart';
import 'package:shopsavvy/Views/Dashboard/dashboard.dart';

class LoginController {
  final HttpController _httpController = HttpController();

  Future<void> commonLogin(context, Map<String, dynamic> data) async {
    CustomUtils.showLoader(context);
    await _httpController
        .doPost(APIRoutes.getRoute('LOGIN'), {}, data)
        .then((Response response) async {
      CustomUtils.hideLoader(context);

      var resp = JsonResponse.fromJson(response.data);
      if (resp.statusCode == 200) {
        await User.saveUser(resp);
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

  Future<bool> verifyUser(String accessToken) async {
    bool httpStatus = false;
    try {
      await _httpController.doPost(
          APIRoutes.getRoute('VERIFY'),
          {'Authorization': 'Bearer $accessToken'},
          {}).then((Response response) async {
        var resp = JsonResponse.fromJson(response.data);
        if (resp.statusCode == 200) {
          await User.saveUser(resp);
          httpStatus = true;
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return httpStatus;
  }

  Future<void> logout(context) async {
    await User.logout();
    Routes(context: context).navigateReplace(const Login());
  }
}
