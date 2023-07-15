import 'dart:convert';

import 'package:dio/dio.dart';

class HttpController {
  Future<Response> doPost(String url, Map<String, dynamic> headers,
      Map<String, dynamic> data) async {
    Dio dioConnection = Dio();
    headers.forEach((key, value) {
      dioConnection.options.headers[key] = value;
    });
    return await dioConnection.post(url, data: data);
  }

  Future<Response> doGet(String url, Map<String, dynamic> headers,
      Map<String, dynamic> data) async {
    Dio dioConnection = Dio();
    headers.forEach((key, value) {
      dioConnection.options.headers[key] = value;
    });
    return await dioConnection.get(url, queryParameters: data);
  }
}
