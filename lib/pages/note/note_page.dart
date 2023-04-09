import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/note/note_controller.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/widget/loading.dart';
import 'package:hoseo_notice/widget/main_appber.dart';
import 'note_list_item.dart';
import 'note_controller.dart';

class NotePage extends GetView<NoteController> {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(builder: (controller) {
      return Scaffold(
        appBar: mainAppbar("알림"),
        body: Container(
          //전체 컨테이너
          child: controller.noaccess
              //와이파이 연결 안됐을때
              ? null
              //목록에 아무것도 없을때
              : (controller.count == false)
                  ? const Center(
                      child: Text(
                        '알림이 없습니다.',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffBCB8B8)),
                      ),
                    )
                  : Column(
                      children: [
                        //알림 선택 삭제 버튼
                        Container(
                          margin: EdgeInsets.fromLTRB(23, 5, 23, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //선택 버튼
                              OutlinedButton(
                                onPressed: () {
                                  controller.selectionButtonClicked();
                                },
                                child: Text("선택"),
                                style: OutlinedButton.styleFrom(
                                  primary: controller.isselButtonClicked
                                      ? const Color(0xff5E5A57)
                                      : const Color(0xffD6DBDE),
                                  // backgroundColor: const Color(0xffF5F4F2),
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  side: BorderSide(
                                      color: controller.isselButtonClicked
                                          ? const Color(0xff5E5A57)
                                          : const Color(0xffD6DBDE),
                                      width: 2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  shadowColor: const Color(0xffC0C0C0),
                                ),
                              ),
                              //삭제 버튼
                              IconButton(
                                  onPressed: () {
                                    //삭제 확인 다이얼로그
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Color(0xffF5F4F2),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        contentPadding:
                                            EdgeInsets.only(top: 10),
                                        title: const Text(
                                          '선택된 알림을 삭제하시겠습니까 ?',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                controller.trashButtonClicked();
                                                controller.isselButtonClicked =
                                                    false;
                                                controller.isButtonActive =
                                                    false;
                                                controller.count == false
                                                    ? const Center(
                                                        child: Text(
                                                          '알림이 없습니다.',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0xffBCB8B8)),
                                                        ),
                                                      )
                                                    : Navigator.pop(context);
                                              },
                                              child: const Text(
                                                '예',
                                                style: TextStyle(
                                                    color: Color(0xffBE1824),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                '아니오',
                                                style: TextStyle(
                                                    color: Color(0xff5E5A57),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16),
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.delete_forever_outlined),
                                  //삭제버튼 활성화/비활성화 여부에 따라 색깔 변경
                                  color: controller.isButtonActive
                                      ? const Color(0xff5E5A57)
                                      : const Color(0xffD6DBDE),
                                  iconSize: 30),
                            ],
                          ),
                        ),
                        //알림 리스트
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15, top: 5, right: 15, bottom: 0),
                            //listview가 위치할 컨테이너
                            child: Loading(
                              isLoading: controller.isLoading,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      color: Color(0xff5E5A57),
                                      onRefresh: _refresh,
                                      child: Container(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const BouncingScrollPhysics(
                                                parent:
                                                    AlwaysScrollableScrollPhysics()),
                                            itemCount:
                                                controller.noteList.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                NoteListItem(
                                                  con: controller,
                                                  note: controller
                                                      .noteList[index],
                                                  idx: index,
                                                )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      );
    });
  }

  //새로고침
  Future _refresh() async {
    //await Future.delayed(Duration(seconds: 0));
    controller.noteList = [];
    controller.onInit();
  }
}
