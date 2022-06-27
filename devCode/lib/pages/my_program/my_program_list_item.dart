import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hoseo_notice/models/programs.dart';
import 'package:hoseo_notice/pages/my_program/my_program_controller.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class MyProgramListItem extends StatelessWidget {
  final Programs programs;
  final idx;
  final MyProgramController con;

  const MyProgramListItem(
      {required this.programs, required this.idx, required this.con});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, right: 20, bottom: 3, left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //프로그램 모집 상태
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            programs.program_state,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          decoration: BoxDecoration(
                              color: programs.program_state == '모집 완료'
                                  ? Color(0xffADADAD).withOpacity(0.4)
                                  : programs.program_state == '모집 중'
                                      ? Color(0xffE7A6A6).withOpacity(0.6)
                                      : Color(0xff7BB0FF).withOpacity(0.4)),
                        ),
                        //프로그램 마일리지 점수
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            programs.mileage + '점',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    //프로그램 제목
                    Container(
                      child: Text(
                        programs.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: programs.program_state == '모집 완료'
                              ? EdgeInsets.only(bottom: 16, top: 16)
                              : null,
                          child: Text(
                            programs.startdate + " ~ " + programs.enddate,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ),

                        //프로그램 취소 버튼
                        Container(
                          child: programs.program_state == '모집 완료'
                              ? null
                              : OutlinedButton(
                                  onPressed: () {
                                    Get.dialog(
                                      //취소 확인하는 다이얼로그
                                      AlertDialog(
                                        backgroundColor: Color(0xffF5F4F2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        contentPadding:
                                            EdgeInsets.only(top: 10),
                                        title: Text(
                                          '프로그램 신청을 취소하시겠습니까?',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                ApiRequest(
                                                    url: PRODUCTION_URL +
                                                        "/program/delete_user_program",
                                                    data: {
                                                      "program_id":
                                                          programs.program_id
                                                    }).del2(
                                                  beforeSend: () {},
                                                  onError: (error) {},
                                                  onSuccess: (data) {
                                                    _refresh();
                                                  },
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Text(
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
                                              child: Text(
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
                                  child: Text('취소'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    primary: Color(0xffBE1824),
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                    side: BorderSide(
                                        color: const Color(0xffBE1824),
                                        width: 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    fixedSize: Size(60, 30),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _refresh() async {
    await Future.delayed(Duration(seconds: 0));
    con.programList = [];
    con.onInit();
  }
}
