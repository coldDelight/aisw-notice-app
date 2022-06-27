import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/models/programs.dart';
import 'package:hoseo_notice/pages/my_program/my_program_provider.dart';

class MyProgramController extends GetxController {
  List<Programs> programList = [];
  bool isLoading = true;

  //리스트에 접근 하지 못했을때 -> true, 접근 했을떄 -> false
  bool noaccess = true;

  // 리스트 안 데이터가 존재할때 -> true, 존재하지 않을 때 -> false
  bool count = false;

  @override
  void onInit() {
    MyProgramProvider().getProgramsList(
      onSuccess1: (programs) {
        programList.addAll(programs);
        isLoading = false;
        noaccess = false;
        if (programList.isNotEmpty) {
          count = true;
        }
        print('my program_cont OnSuccess');
        update();
      },
      onError: (error) {
        isLoading = false;
        print(error);
        noaccess = true;
        update();
        print("My progrma cont Error");
      },
      beforeSend: () {},
    );
    super.onInit();
  }
}
