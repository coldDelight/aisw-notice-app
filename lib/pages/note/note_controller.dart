import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/models/note.dart';
import 'package:hoseo_notice/pages/note/note_provider.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class NoteController extends GetxController {
  List<Note> noteList = [];
  bool isLoading = true;

  //선택버튼 눌렸는지 안눌렸는지
  var isselButtonClicked = false;

  //삭제버튼 눌렀는지 안눌렀는지
  var istrashButtonClicked = true;

  //선택된 타일 인덱스 리스트
  List<int> iddxlist = [];

  bool noaccess = true;
  bool count = false;

  //삭제버튼 상태 ( 활성/ 비활성 )
  bool isButtonActive = false;

  @override
  void onInit() {
    //알림 리스트 받아오기
    NoteProvider().getNoteList(
      onSuccess1: (Note) {
        if (kDebugMode) {
          print("note_cont OnSuccess");
        }
        noteList.addAll(Note);
        isLoading = false;
        noaccess = false;
        if (noteList.isNotEmpty) {
          count = true;
        }
        update();
      },
      onError: (error) {
        isLoading = false;
        if (kDebugMode) {
          print(error);
          print("Note Error");
        }
        noaccess = true;
        update();
      },
      beforeSend: () {},
    );
    super.onInit();
  }

  void updateNote() {
    update();
  }

  //선택버튼 상태
  void selectionButtonClicked() {
    this.isselButtonClicked = !isselButtonClicked;
    for (int i = 0; i < iddxlist.length; i++) {
      noteList[iddxlist[i]].tileColor = Colors.white;
    }
    if (!isselButtonClicked) {
      iddxlist = [];
      istrashButtonClicked = false;
    }
    update();
  }

  //타일 선택, 색상 변경, 인덱스값 넘겨 주는
  void tileTab(value, active) {
    if (active) {
      iddxlist.add(value);
    } else {
      iddxlist.remove(value);
    }
    if (kDebugMode) {
      print(iddxlist);
      for (int i = 0; i < iddxlist.length; i++) {
        print("73  " + noteList[iddxlist[i]].user_push_id);
      }
    }

    update();
  }

  //휴지통버튼 활성
  void trashButtonAct() {
    iddxlist.isNotEmpty ? isButtonActive = true : isButtonActive = false;
    update();
  }

  //선택된 타일 삭제
  void trashButtonClicked() {
    if (isButtonActive == true) {
      print("버튼 클릭 ");
      for (int i = 0; i < iddxlist.length; i++) {
        print(iddxlist[i]);
        ApiRequest(
            url: "/push/delete",
            data: {"user_push_id": noteList[iddxlist[i]].user_push_id}).put2(
          beforeSend: () {},
          onSuccess: (data) {
            _refresh();
            print("delete");
          },
          onError: (error) {},
        );
      }
    }
  }

  Future _refresh() async {
    //await Future.delayed(Duration(seconds: 0));
    noteList = [];
    onInit();
  }
}
