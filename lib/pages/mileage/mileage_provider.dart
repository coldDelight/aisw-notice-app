import 'package:hoseo_notice/models/mileage.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class MileageProvider {
  void getMileageList({
    required Function() beforeSend,
    required Function(List<Mileage> posts) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    //전체 마일리지 리스트
    ApiRequest(url: "/mileage/mymileage").get2(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        print(data["Data"]);
        onSuccess1((data["Data"] as List)
            .map((Json) => Mileage.fromJson(Json))
            .toList());
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}

class CurrentMileageProvider {
  void getCurrentMileage({
    required Function() beforeSend,
    required Function(List<CurrentMileage> currentmileage) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    //현재 학기 마일리지 점수
    ApiRequest(url: "/mileage/semester_mileage").get2(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        print(data["Data"]);
        onSuccess1((data["Data"] as List)
            .map((Json) => CurrentMileage.fromJson(Json))
            .toList());
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
