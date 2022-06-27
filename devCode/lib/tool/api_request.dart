import 'package:dio/dio.dart';
import 'package:hoseo_notice/themes/app_value.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? data;

  ApiRequest({
    required this.url,
    this.data,
  });

  Dio _dio() {
    return
      getCookie() == "" ?
      Dio(
          BaseOptions(
            baseUrl: PRODUCTION_URL,
            connectTimeout: 10000,
            receiveTimeout: 7000,
          )) : // jwt 토큰 없으면
      Dio(BaseOptions(
          baseUrl: PRODUCTION_URL,
          connectTimeout: 10000,
          receiveTimeout: 7000,
          headers: {
            "Cookie": getCookie(), //로그인중이면 jwt 값 들어감
          }));
  }

  void get2({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    _dio().get(url, queryParameters: data).then((res) {
      // print("api_request.dart : dio부분 결과값");
      // print(res);
      onSuccess(res.data);
    }).catchError((error) {
      onError(error);
    });
  }
  void del2({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    _dio().delete(url, data: data).then((res) {
      onSuccess(res.data);
    }).catchError((error) {
      onError(error);
    });
  }

  void post2({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    _dio().post(url, data: data).then((res) {
      onSuccess(res.data);
    }).catchError((error) {
      onError(error);
    });
  }

  void put2({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    _dio().put(url, data: data).then((res) {
      onSuccess(res.data);
    }).catchError((error) {
      onError(error);
    });
  }

}
