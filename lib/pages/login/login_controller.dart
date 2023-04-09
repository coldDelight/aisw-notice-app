import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var id = "";
  var pw = "";
  String errMessage = "";
  bool err = false;

  //와이파이 연결 상태
  int connectionType = 0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    GetConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> GetConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        update();
        break;
    }
  }

  @override
  void onClose() {}

  void showErr(String errMessage) {
    err = true;
    this.errMessage = errMessage;
    update();
  }

  void hideErr() {
    err = false;
    this.errMessage = "";
    update();
  }

  void insert_id(String id) {
    this.id = id;
    update();
  }

  void insert_pw(String pw) {
    this.pw = pw;
    update();
  }
}
