import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/themes/user_info.dart';
import 'package:hoseo_notice/tool/user_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AccountController extends GetxController {
  var isSwitched = UserInfo.psuh_accept=="동의"?true:false;
  var isActive="";
  int connectionType =0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );
  Map<String, dynamic> stu = {
    "STUDENT_ID": "",
    "NM": "",
    "LEVEL": "",
    "DEPT_NM": "",
    "SCHYR": "",
    "iat": "",
    "exp": "",
    "iss": ""
  };

  @override
  void onInit() async {
    String? tok = await UserSecureStorage.getSecureValue(SCURE_JWT_KEY);
    stu = JwtDecoder.decode(tok!);
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    update();

    GetConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  void switchChange(bool isSwitched) {
    this.isSwitched = isSwitched;
    isSwitched? isActive="동의":isActive="미동의";
    UserInfo.psuh_accept = isActive;
    UserSecureStorage.setSecureValue(SCURE_PUSH_KEY, isActive);
    update();
  }

  Future <void> GetConnectionType() async{
    var connectivityResult;
    try{
      connectivityResult = await (_connectivity.checkConnectivity());
    }on PlatformException catch(e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch(result)
    {
      case ConnectivityResult.wifi:
        connectionType=1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType=2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType=0;
        update();
        break;

    }
  }


  void snackBar() {
    if(connectionType == 0)
    {Get.snackbar('인터넷 연결 오류', '연결 상태를 확인하고 다시 시도해주세요',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(seconds: 2));}
    update();
  }
}
