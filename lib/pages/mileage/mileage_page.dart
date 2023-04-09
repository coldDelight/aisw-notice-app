import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/themes/user_info.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/widget/main_appber.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'mileage_list_item.dart';
import 'mileage_controller.dart';
import 'package:hoseo_notice/widget/loading.dart';

class MileagePage extends GetView<MileageController> {
  const MileagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MileageController>(builder: (controller) {
      return Scaffold(
          appBar: mainAppbar("마일리지"),
          body: controller.noaccess
              //와이파이 연결 안됐을떄
              ? null
              : Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          //사용자 이름, 학기, 현재 마일리지, 기준일 표시
                          Container(
                            margin:
                                EdgeInsets.only(top: 15, left: 15, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.stu['NM']}님의',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  controller.filteringDay(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "SW",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffBD1824)),
                                    ),
                                    Text(
                                      "인재 마일리지",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      " 점수는?",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(top: 20, left: W * 0.437, right: W * 0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  (controller.nowmileage).toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 64,
                                    color: Color(0xffBD1824),
                                  ),
                                ),
                                Text(
                                  "점",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                right: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "기준일 : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff5E5A57),
                                    ),
                                  ),
                                  Text(
                                    controller.getToday(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff5E5A57),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),

                    //마일리지 리스트
                    Flexible(
                      flex: 7,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffF5F4F2),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "마일리지 내역",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        DropdownButton(
                                          value: controller.selectedsemester,
                                          items:
                                              controller.semester.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (choice) {
                                            controller.changeSelectSemester(
                                                choice.toString());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            controller.count == false
                                ? const Flexible(
                                    child: Center(
                                      child: Text(
                                        '마일리지 내역이 없습니다.',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xffBCB8B8)),
                                      ),
                                    ),
                                  )
                                : Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30, top: 30),
                                      child: Loading(
                                        isLoading: controller.isLoading,
                                        child: ListView.builder(
                                            itemCount:
                                                controller.selectedList.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                MileageListItem(
                                                    mileage: controller
                                                        .selectedList[index])),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
    });
  }
}
