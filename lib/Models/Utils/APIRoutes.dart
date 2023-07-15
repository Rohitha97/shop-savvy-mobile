class APIRoutes {
  static const String _baseRoute = 'http://192.168.1.102:8000/api/';

  static String getRoute(String key) {
    switch (key) {
      case 'REGISTER':
        key = "${_baseRoute}auth/register";
        break;
      case 'LOGIN':
        key = '${_baseRoute}auth/login';
        break;
      case 'PRODUCTS_GET':
        key = '${_baseRoute}products/get';
        break;
      case 'CART_PRODUCTS_GET':
        key = '${_baseRoute}cart/products/get';
        break;
      case 'CART_PAID_PRODUCTS_GET':
        key = '${_baseRoute}cart/products/paid';
        break;
      case 'VERIFY_CART':
        key = '${_baseRoute}cart/payment/verify';
        break;
      case 'CART_PRODUCTS_REMOVE':
        key = '${_baseRoute}cart/products/remove';
        break;
      case 'CART_ADD':
        key = '${_baseRoute}cart/add';
        break;
      case 'DONE_PAYMENT':
        key = '${_baseRoute}cart/payment/done';
        break;
      case 'HISTORY':
        key = '${_baseRoute}cart/history/get';
        break;
    }
    return key;
  }
}
