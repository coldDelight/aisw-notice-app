import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/notice/notice_controller.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:word_break_text/word_break_text.dart';

class ProgramApplication extends GetxController {
  Color acceptIcon = const Color(0xff5E5A5C);
  bool isAccept = false;

  void acceptCollection() {
    isAccept = !isAccept;
    isAccept
        ? acceptIcon = AppColor.mainColor
        : acceptIcon = const Color(0xff5E5A5C);
    update();
  }
}

class ProgramApplicationDialog extends GetView<ProgramApplication> {
  late NoticeController cont;
  late String? programId;


  ProgramApplicationDialog(this.cont, this.programId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgramApplication>(builder: (controller) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: SizedBox(
          height: 250,
          width: W * 0.77,
          child: Column(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                  child: Column(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              const Text(
                                "신청 안내",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20, height: 0.5),
                                textAlign: TextAlign.center,
                              ),
                              const Divider(
                                thickness: 1, color: Color(0xffC4C4C4),
                              ),
                              cont.noticeContent[0].DEPT_NM != "null"
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text("신청 가능한 학과",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color:  Color(0xff5E5A57))),
                                  Container(
                                      margin: const EdgeInsets.only(top : 5,bottom : 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: Colors.red[400],borderRadius: BorderRadius.circular(10)),
                                      child:
                                      Center(child: WordBreakText("${cont.noticeContent[0].DEPT_NM}",spacingByWrap: true,spacing: 5,style: const TextStyle(color:Colors.white)))
                                    // TextFormField(
                                    //   enabled: false,
                                    //   decoration: InputDecoration(
                                    //     fillColor: Colors.red[500],
                                    //       filled: true,
                                    //       hintStyle: const TextStyle(color: Colors.white, ),
                                    //       hintMaxLines: 2,
                                    //       contentPadding: const EdgeInsets.only(left: 5),
                                    //       disabledBorder: OutlineInputBorder(
                                    //           // borderSide: BorderSide(width: 1.5,color: Colors.black,)
                                    //         borderRadius: BorderRadius.circular(10.0),
                                    //         borderSide: BorderSide.none,
                                    //       ),
                                    //       hintText: WordBreakText("${cont.noticeContent[0].DEPT_NM}",spacingByWrap: true,)
                                    // ),
                                  ),
                                  const Text("위 해당 학과만 신청할 수 있습니다.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff5E5A57))),
                                ],
                              )
                                  : const Text(""),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.black12),
                                  onPressed: () {
                                    controller.acceptCollection();
                                  },
                                  child: RichText(
                                    text: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(
                                            Icons.check,
                                            color: controller.acceptIcon,
                                            size: 20,
                                          )),
                                      const TextSpan(
                                          text: " 개인정보수집동의",
                                          style: TextStyle(
                                              color: Color(0xff000000)))
                                    ]),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(Size(double.infinity, H*0.075)),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(20)))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff5E5A57)),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.black12)),
                                child: const Text("취소",
                                    style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    )),
                              )),
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: TextButton(
                                onPressed: controller.isAccept
                                    ? () {
                                  ApiRequest(
                                      url: PRODUCTION_URL +
                                          "/program/user_answer",
                                      data: {
                                        "program_id": programId,
                                        "accept": "동의"
                                      }).post2(
                                      beforeSend: () {},
                                      onSuccess: (data) {
                                        data['Message'] == "성공하였습니다."
                                            ? Get.snackbar(
                                            "${data["Message"]}",
                                            "프로그램이 정상적으로 신청되었습니다.",
                                            snackPosition:
                                            SnackPosition.TOP,
                                            backgroundColor:
                                            Colors.green[400],
                                            colorText: Colors.white,
                                            duration: const Duration(
                                                milliseconds: 1500))
                                            : Get.snackbar(
                                            "${data["Error_Message"]}",
                                            "다시 확인해주세요",
                                            snackPosition:
                                            SnackPosition.TOP,
                                            backgroundColor:
                                            Colors.red[400],
                                            colorText: Colors.white,
                                            duration: const Duration(
                                                milliseconds: 1500));
                                      },
                                      onError: (err) {
                                        print(err);
                                      });
                                  Get.back();
                                }
                                    : null,
                                style: controller.isAccept
                                    ? ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(Size(double.infinity, H*0.075)),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                Radius.circular(20)))),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Color(0xffAA1621)),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.black12))
                                    : ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(Size(double.infinity, H*0.075)),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                              Radius.circular(20)))),
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.black12),
                                ),
                                child: const Text(
                                  "신청하기",
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
