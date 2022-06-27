import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/my_program/my_program_controller.dart';
import 'package:hoseo_notice/pages/my_program/my_program_list_item.dart';
import 'package:hoseo_notice/widget/loading.dart';

class MyProgramPage extends GetView<MyProgramController> {
  const MyProgramPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProgramController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              '내가 신청한 프로그램',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          body: Container(
            //와이파이 연결 안됐을때
            child: controller.noaccess
                ? null
                //목록에 아무것도 없을 때
                : (controller.count == false)
                    ? Center(
                        child: Text(
                          '신청한 프로그램이 없습니다.',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffBCB8B8)),
                        ),
                      )
                    //프로그램 리스트
                    : Container(
                        child: Loading(
                        isLoading: controller.isLoading,
                        child: RefreshIndicator(
                          color: Color(0xff5E5A57),
                          onRefresh: _refresh,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: controller.programList.length,
                            itemBuilder: (context, index) => MyProgramListItem(
                              programs: controller.programList[index],
                              idx: index,
                              con: controller,
                            ),
                          ),
                        ),
                      )),
          ),
        );
      },
    );
  }

  //초기화
  Future _refresh() async {
    await Future.delayed(Duration(seconds: 0));
    controller.programList = [];
    controller.onInit();
  }
}
