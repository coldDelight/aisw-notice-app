import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/widget/loading.dart';
import 'package:hoseo_notice/widget/main_appber.dart';
import 'notice_controller.dart';
import 'notice_list_item.dart';

class NoticePage extends GetView<NoticeController> {
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(builder: (controller) {
      return Scaffold(
        appBar: noticeAppbar("공지사항",controller),
        body: Loading(
          isLoading: controller.isLoading,
          child: GestureDetector(
            onTap: (){
              Get.focusScope!.unfocus();
            },
            child: RefreshIndicator(
              color: const Color(0xff5E5A57),
              onRefresh: _refresh,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF5F4F2)),
                margin: const EdgeInsets.only(top: 5),
                width: W,
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: controller.noticeList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) =>
                              NoticeListItem(
                                notice: controller.noticeList[index],
                                con: controller,
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future _refresh() async {
    //await Future.delayed(Duration(seconds: 0));
    controller.noticeList = [];
    controller.data = [];
    controller.onInit();
  }
}
