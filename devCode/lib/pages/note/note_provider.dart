import 'package:flutter/foundation.dart';
import 'package:hoseo_notice/models/note.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class NoteProvider {
  void getNoteList({
    required Function() beforeSend,
    required Function(List<Note> note) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    // 알림 리스트
    ApiRequest(url:"/push").get2(
        beforeSend: () => {if (beforeSend != null) beforeSend()},
        onSuccess: (data) {
          if (kDebugMode) {
            // print(data["Data"]);
          }
          onSuccess1((data["Data"] as List)
              .map((Json) => Note.fromJson(Json))
              .toList());
        },
        onError: (error) => {if (onError != null) onError(error)});
  }
}
