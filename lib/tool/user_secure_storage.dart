import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hoseo_notice/themes/app_value.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage(); //각 플랫폼 내부저장소 사용 어플종료해도 값을 암호화해서 가지고있는다

  static const _jwt = "jwt";// 내부 저장소에 저장시 사용 할 key 값


  static void setJwt(String jwt) async {// 로그인시 jwt 값을 내부저장소에 저장하는 함수
    setCookie(jwt);//api 통신에 사용 header에 넣을 값
    await _storage.write(key: _jwt, value: jwt);// key 값을 사용해서 저장
    if (kDebugMode) {
      print("user_secure_storage: jwt has been set");
    }
  }

  static void setSecureValue(String key,String value) async {// 로그인시 jwt 값을 내부저장소에 저장하는 함수
    await _storage.write(key: key, value: value);// key 값을 사용해서 저장
    if (kDebugMode) {
      print("user_secure_storage: $key has been set");
    }
  }
  static Future<String?> getSecureValue(String key) async {//저장된 값을 가지고 오는 함수
    if (kDebugMode) {
      print("user_secure_storage: $key has been get");
    }
    return await _storage.read(key: key);//key 값으로 가지고 온다
  }

  static void delSecureValue(String key) async {//로그아웃시 jwt 값을 내부저장소에서 삭제하는 함수
    await _storage.delete(key: key);//key 값으로 삭제
    if (kDebugMode) {
      print("user_secure_storage: $key has been delete");
    }
  }
  static void delAll() async =>
      await _storage.deleteAll();

  static Future<Map<String, String>> getAll() async =>
      await _storage.readAll();

}