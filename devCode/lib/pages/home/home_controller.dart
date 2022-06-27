import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/models/mileage.dart';

import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/models/programs.dart';
import 'package:hoseo_notice/pages/home/home_provider.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class HomeController extends GetxController {
  bool isLoading = true;
  String mileage ='';
  int nowmileage=0;

  List<Notice> homeNoticeList = [];
  //처음 값이 없어 빨간화면 오류 처리
  List<Programs> programList =[Programs(title: "",enddate: "",mileage: "",program_id: "",program_state: "",startdate: "")];
  List<CurrentMileage> currentmileageList =[];
  List<Notice> homeevent =[];


  @override
  void onInit() {
    HomeNoticeProvider().getHomeNoticeList(
      onSuccess1: (Notice) {
        if (kDebugMode) {
          print("home notice in 성공");
        }
        homeNoticeList.addAll(Notice);
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        if (kDebugMode) {
          print(error);
          print("program cont Error");
        }
        update();
      },
      beforeSend: () {},
    );

    CurrentMileageProvider().getCurrentMileage(
      onSuccess1: (currentmileage) {
        currentmileageList.addAll(currentmileage);
        // print("HomeMileage cont Onsuccess");
        // print("총 점 ");
        nowSemesterMileage();
        // print((currentmileage).toString());
        update();
      },
      onError: (error) {
        isLoading = false;
        // print(error);
        update();
        // print("HomeMileage cont Error");
      },
      beforeSend: () {},
    );
    HomeProgramProvider().getHomeProgramsList(
        onSuccess1: (programs) {
          programList.removeLast();//처음 추가한값 제거
          programList.addAll(programs);
          // print("HomeProgram cont Onsuccess");
          update();
          },
        onError: (error) {
          isLoading = false;
          // print(error);
          update();
          // print("HomeProgram cont Error");
        },
        beforeSend: (){},
    );
    super.onInit();
  }


  void eventImage() {
    ApiRequest(
      url: PRODUCTION_URL + "/notice/download?file_name=event1.png", data: {}).get2(
      beforeSend: () {},
      onError: (error) {},
      onSuccess: (data) {},
    );
    update();
  }

  void nowSemesterMileage() {
    for (int i=0; i <currentmileageList.length;i++) {
      nowmileage = int.parse(currentmileageList[i].semester);
    }
  }
  }

