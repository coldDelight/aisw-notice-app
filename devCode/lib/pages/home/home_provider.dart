import 'package:flutter/foundation.dart';
import 'package:hoseo_notice/models/programs.dart';
import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/models/mileage.dart';

class HomeNoticeProvider {
  void getHomeNoticeList({
    required Function() beforeSend,
    required Function(List<Notice> notice) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    ApiRequest(url:"/notice/all_app").get2(
        beforeSend: () => {beforeSend()},
        onSuccess: (data) {
          onSuccess1(
              (data["Data"] as List).map((json) => Notice.fromJson(json)).toList());
        },
        onError: (error) => { onError(error)}
    );
  }
}

class CurrentMileageProvider {
  void getCurrentMileage({
    required Function() beforeSend,
    required Function(List <CurrentMileage> currentmileage) onSuccess1,
    required Function(dynamic error) onError,
  })
  {
    ApiRequest(url:"/mileage/semester_mileage").get2(
      beforeSend: () => { beforeSend()},
      onSuccess: (data) {
        onSuccess1((data["Data"] as List).map((json) => CurrentMileage.fromJson(json)).toList());
      },
      onError: (error) => { onError(error)},
    );
  }
}

class HomeProgramProvider {
  void getHomeProgramsList({
    required Function() beforeSend,
    required Function(List<Programs> posts) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    ApiRequest(url:"/program/app_program").get2(
      beforeSend: () => {beforeSend()},
      onSuccess: (data) {
        if (kDebugMode) {
          print(data);
        }
        onSuccess1((data["Data"] as List)
            .map((json) => Programs.fromJson(json))
            .toList());
      },
      onError: (error) => {onError(error)},
    );
  }
}
