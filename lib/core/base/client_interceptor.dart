import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ClientInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _apiLogger(options);
    super.onRequest(options, handler);
  }

  void _apiLogger(RequestOptions options) {
    log("Ⓜ️Ⓜ️Ⓜ️ 𝑴𝒆𝒕𝒉𝒐𝒅------->> ${options.method.toString()}");
    log("🌐🌐🌐 𝑬𝑵𝑫𝑷𝑶𝑰𝑵𝑻---->>${options.uri.toString()}\n");
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print("#### Error for the Api: --> ${err.requestOptions.path} \n${jsonEncode(err.response?.data)}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Response of-->${jsonEncode(response.data)}");

    super.onResponse(response, handler);
  }
}
