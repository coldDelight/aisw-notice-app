import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';



class DashboardController extends GetxController {

  int connectionType =0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  var tabIndex = 2;

  void changeTabIndex(int index) {
    tabIndex = index;
    if(connectionType == 0) {Get.snackbar('인터넷 연결 오류', '연결 상태를 확인하고 다시 시도해주세요',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(seconds: 2));}
    update();
  }

  @override
  void onInit() {
    GetConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);

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

  @override
  void onClose(){
  }
}
