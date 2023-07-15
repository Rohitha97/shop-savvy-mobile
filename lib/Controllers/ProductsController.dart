import 'package:dio/dio.dart';
import 'package:shopsavvy/Controllers/Common/HttpController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Utils/APIRoutes.dart';
import 'package:shopsavvy/Models/Utils/JsonResponse.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';

class ProductsController {
  final HttpController _httpController = HttpController();

  Future<dynamic> getProducts(context, Map<String, dynamic> data) async {
    dynamic listResp = [];
    await _httpController
        .doGet(APIRoutes.getRoute('PRODUCTS_GET'), {}, data)
        .then((Response response) async {
      listResp = JsonResponse.fromJson(response.data).data;
    });

    return listResp;
  }

  Future<dynamic> getCartProducts(context) async {
    User? storedUser = await User.getUser();
    dynamic data = [];
    await _httpController.doGet(APIRoutes.getRoute('CART_PRODUCTS_GET'), {},
        {'user': storedUser.id.toString()}).then((Response response) async {
      data = JsonResponse.fromJson(response.data).data;
    });
    print(data);

    return data;
  }

  Future<dynamic> addCartProduct(context, String rfid) async {
    User? storedUser = await User.getUser();
    dynamic data = [];
    await _httpController.doGet(APIRoutes.getRoute('CART_ADD'), {}, {
      'user': storedUser.id.toString(),
      'rfid': rfid,
    }).then((Response response) async {
      data = JsonResponse.fromJson(response.data).data['products'];
    });
    return data;
  }

  Future<dynamic> doPayment(context) async {
    User? storedUser = await User.getUser();
    dynamic data = [];
    await _httpController.doGet(APIRoutes.getRoute('DONE_PAYMENT'), {}, {
      'user': storedUser.id.toString(),
    }).then((Response response) async {
      data = JsonResponse.fromJson(response.data).data;
    });
    return data;
  }

  Future<dynamic> getCartPaidProducts(context, data) async {
    dynamic data0 = [];
    await _httpController
        .doGet(APIRoutes.getRoute('CART_PAID_PRODUCTS_GET'), {}, data)
        .then((Response response) async {
      print(response);
      data0 = JsonResponse.fromJson(response.data).data;
    });

    return data0;
  }

  Future<dynamic> verifyCart(context, data) async {
    dynamic data0 = [];
    await _httpController
        .doGet(APIRoutes.getRoute('VERIFY_CART'), {}, data)
        .then((Response response) async {
      print(response);
      data0 = JsonResponse.fromJson(response.data).data;
    });

    return data0;
  }

  Future<void> deleteCartProduct(context, data) async {
    User? storedUser = await User.getUser();
    data['user'] = storedUser.id.toString();
    await _httpController
        .doGet(APIRoutes.getRoute('CART_PRODUCTS_REMOVE'), {}, data)
        .then((Response response) async {});
  }

  Future<dynamic> getHistory(context) async {
    User? storedUser = await User.getUser();
    dynamic data = [];
    await _httpController.doGet(APIRoutes.getRoute('HISTORY'), {}, {
      'user': storedUser.id.toString(),
    }).then((Response response) async {
      print(response);
      data = JsonResponse.fromJson(response.data).data;
    });
    return data;
  }
}
