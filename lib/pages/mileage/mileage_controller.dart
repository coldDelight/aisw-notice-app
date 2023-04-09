import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hoseo_notice/models/mileage.dart';
import 'package:hoseo_notice/pages/mileage/mileage_list_item.dart';
import 'package:hoseo_notice/pages/mileage/mileage_provider.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/user_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MileageController extends GetxController {
  bool isLoading = true;

  //전체 마일리지 리스트
  List<Mileage> mileageList = [];

  //전체 마일리지 리스트 중 dropdownbox에서 선택된 해당 리스트
  List<Mileage> selectedList = [];

  //현재 학기 마일리지 점수 받아오는 리스트
  List<CurrentMileage> currentmileageList = [];

  // int totalMileage = 0;

  //전체 마일리지 리스트에서 학기 받아오는 Set
  Set<String> semester = {};
  List<String> semesterMenuItem = [];
  List<DropdownMenuItem<String>> item = [];

  //현재 학기
  String filtersemester = '';

  //dropdownbox에서 선택된 학기
  String selectedsemester = '';

  //현재 학기 점수
  int nowmileage = 0;

  //리스트에 접근 하지 못했을때 -> true, 접근 했을떄 -> false
  bool noaccess = true;

  // 리스트 안 데이터가 존재할때 -> true, 존재하지 않을 때 -> false
  bool count = false;

  //사용자 이름
  Map<String, dynamic> stu = {
    "NM": "",
  };

  List<DropdownMenuItem<String>> menuItem() {
    item = [];
    for (int i = 0; i < semester.length; i++) {
      print(i);
      item.add(DropdownMenuItem(
        value: semester.toList()[i],
        child: Text(semester.toList()[i]),
      ));
    }

    return item;
  }

  //dropdownbox item이 선택되면 변경
  void changeSelectSemester(String choicesemester) {
    selectedsemester = choicesemester;
    filtering(selectedsemester);
    if (selectedList.isEmpty) {
      count = false;
    } else {
      count = true;
    }
    update();
  }

  @override
  void onInit() async {
    //사용자 정보에서 이름 받아오기
    String? tok = await UserSecureStorage.getSecureValue(SCURE_JWT_KEY);
    stu = JwtDecoder.decode(tok!);

    //전체 마일리지 리스트 받아오기
    MileageProvider().getMileageList(
      onSuccess1: (mileage) {
        mileageList.addAll(mileage);

        //현재 학기 설정
        final nowDate = filteringDay();
        //선택된 학기로 리스트 필터링
        filtering(selectedsemester);
        if (mileageList.isNotEmpty) {
          count = true;
        }
        isLoading = false;
        noaccess = false;

        // totalMileageInit();

        //전체 마일리지 리스트에서 학기 받아오기
        for (int i = 0; i < mileageList.length; i++) {
          semester.add(mileageList[i].date_time);
        }

        //dropdown item에서 현재 학기가 포함되지 않을때 포함 시키기
        if (semester.contains(nowDate)) {
        } else {
          semester.add(nowDate); // 현재 날짜 학기 드롭다운 메뉴에 추가
          count = false;
        }

        print("it is gefe");
        var tmp = semester.toList();
        print(tmp);

        for (int i = 0; i < tmp.length; i++) {
          semesterMenuItem.add(tmp[i]);
          print(semesterMenuItem[i]);
        }
        print(semesterMenuItem);

        update();
      },
      onError: (error) {
        isLoading = false;
        noaccess = true;
        print(error);
        update();
        print("mileage cont Error");
      },
      beforeSend: () {},
    );

    //현재 학기 마일리지 점수 받아오기
    CurrentMileageProvider().getCurrentMileage(
      onSuccess1: (currentmileage) {
        currentmileageList.addAll(currentmileage);
        nowSemesterMileage();
        update();
      },
      onError: (error) {
        isLoading = false;
        print(error);
        update();
        print("currentmileage cont Error");
      },
      beforeSend: () {},
    );

    super.onInit();
  }

  //오늘 날짜 받아오는 함수
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy.MM.dd');
    String strToday = formatter.format(now);
    return strToday;
  }

  // 리스트 마일리지 합계
  // void totalMileageInit() {
  //   totalMileage = 0;
  //   for (int i = 0; i < mileageList.length; i++) {
  //     totalMileage = totalMileage + int.parse(mileageList[i].program_mileage);
  //   }
  // }

  //현재 학기 점수 받아오는 함수
  void nowSemesterMileage() {
    for (int i = 0; i < currentmileageList.length; i++) {
      nowmileage = int.parse(currentmileageList[i].semester);
    }
  }

  //dropdownbox item중에서 현재학기를 기본 설정하는 함수
  String filteringDay() {
    DateTime now = DateTime.now();
    var filteryear = now.year;
    // var filteryear = 2023;
    var filtermonth = now.month;

    if (filtermonth > 2 && filtermonth < 9) {
      filtersemester = (filteryear).toString() + '년도 1학기';
    } else if (filtermonth == 1 || filtermonth == 2) {
      filtersemester = (filteryear - 1).toString() + '년도 2학기';
    } else
      filtersemester = (filteryear).toString() + '년도 2학기';
    selectedsemester = filtersemester;
    return filtersemester;
  }

  // 전체 리스트 학기별로 필터링 하는 함수
  void filtering(String cs) {
    selectedList = mileageList.where((i) => i.date_time == cs).toList();
    update();
  }
}
