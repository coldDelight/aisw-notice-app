import 'package:flutter/foundation.dart';
import 'package:hoseo_notice/models/programs.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class MyProgramProvider {
  void getProgramsList({
    required Function() beforeSend,
    required Function(List<Programs> posts) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    //신청한 프로그램 리스트
    ApiRequest(url: "/program/myprogram").get2(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        if (kDebugMode) {
          print(data);
        }
        onSuccess1((data["Data"] as List)
            .map((Json) => Programs.fromJson(Json))
            .toList());
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
