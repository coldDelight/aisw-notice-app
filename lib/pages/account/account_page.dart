import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/account/account_controller.dart';
import 'package:hoseo_notice/pages/my_program/my_program_page.dart';
import 'package:hoseo_notice/pages/privacy_policy/privacy_policy_dialog.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/tool/auth.dart';
import 'package:hoseo_notice/widget/main_appber.dart';
import 'account_controller.dart';
import 'package:switcher_button/switcher_button.dart';

class AccountPage extends GetView<AccountController> {
  static const FontWeight titleW = FontWeight.w800;
  static const FontWeight contentW = FontWeight.w400;
  static const cardBackgroundColor = Color(0xffF5F4F2);
  static const arrowIconColor = Color(0xff5E5A57);
  static const textColor = Color(0xff000000);

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (controller) {
      return Scaffold(
        appBar: mainAppbar("내 정보"),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                              color: cardBackgroundColor,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '프로필',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: titleW,
                                  ),
                                ),
                                Container(
                                  height: 88,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0xffD6DBDE)))),
                                  padding: const EdgeInsets.only(left: 10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            '${controller.stu['NM']}님',
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: titleW,
                                            ),
                                          ),
                                          Text(
                                            ' ${controller.stu['STUDENT_ID']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: contentW),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${controller.stu['DEPT_NM']}',
                                        style: const TextStyle(
                                            color: Color(
                                              0xff686868,
                                            ),
                                            fontSize: 15,
                                            fontWeight: contentW),
                                      )
                                    ],
                                  ),
                                ),
                                const Text(
                                  '내 활동',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: titleW,
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0xffD6DBDE)))),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(const MyProgramPage());
                                      controller.snackBar();
                                    },
                                    style: TextButton.styleFrom(
                                        primary: textColor),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                            child: Text(
                                          '내가 신청한 프로그램',
                                          style: TextStyle(
                                              fontWeight: contentW,
                                              fontSize: 16,
                                              color: textColor),
                                        )),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: arrowIconColor,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  '수신 설정',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: titleW,
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0xffD6DBDE)))),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                          child: Text(
                                        'Push 알림',
                                        style: TextStyle(
                                            fontWeight: contentW, fontSize: 16),
                                      )),
                                      SwitcherButton(
                                        value: controller.isSwitched,
                                        size: 45,
                                        onColor: AppColor.mainColor,
                                        offColor: const Color(0xffD6DBDE),
                                        onChange: (value) {
                                          controller.switchChange(value);
                                          ApiRequest(
                                              url: PRODUCTION_URL +
                                                  "/auth/push-message",
                                              data: {
                                                "active": controller.isActive,
                                                "device_token": FB_TOKEN
                                              }).put2(
                                              beforeSend: () {},
                                              onSuccess: (data) {
                                                print(data);
                                                print("push change success");
                                              },
                                              onError: (err) {});
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const Text(
                                  '고객 지원',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: titleW,
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0xffD6DBDE)))),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                          child: Text(
                                        '버전 정보',
                                        style: TextStyle(
                                            fontWeight: contentW, fontSize: 16),
                                      )),
                                      Text(
                                        '현재 ' + APP_VERSION,
                                        style: TextStyle(
                                            fontWeight: contentW,
                                            fontSize: 14,
                                            color: arrowIconColor),
                                      )
                                    ],
                                  ),
                                ),
                                const Text(
                                  '서비스 약관',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: titleW,
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0xffD6DBDE)))),
                                  child: TextButton(
                                    onPressed: () {
                                      ApiRequest(
                                              url: PRODUCTION_URL +
                                                  "/agreement/read_one")
                                          .get2(
                                        // api로 가장 최근 개인정보 동의서 data 가지고 온다
                                        beforeSend: () => {},
                                        onSuccess: (res) {
                                          Get.dialog(privacyPolicyDialog(false,
                                              res["Data"], null)); // 개인정보 동의 확인
                                        },
                                        onError: (error) {},
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                        primary: textColor),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                            child: Text(
                                          '개인 정보 처리 방침',
                                          style: TextStyle(
                                              fontWeight: contentW,
                                              fontSize: 16,
                                              color: textColor),
                                        )),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: arrowIconColor,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0xffD6DBDE)))),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(() => LicensePage(
                                            applicationName: "호서대학교AISW공지",
                                            applicationIcon: Image.asset(
                                              'images/mainIcon.png',
                                              width: W * 0.3,
                                            ),
                                            applicationLegalese:
                                                "Hoseo Univ AISW IR_LAB",
                                            applicationVersion: APP_VERSION,
                                          ));
                                    },
                                    style: TextButton.styleFrom(
                                        primary: Colors.black12),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                            child: Text(
                                          '오픈소스 라이센스',
                                          style: TextStyle(
                                              fontWeight: contentW,
                                              fontSize: 16,
                                              color: textColor),
                                        )),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: arrowIconColor,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                    child: OutlinedButton(
                                        onPressed: () {
                                          Auth().logout(); //로그아웃

                                          //라우트 이동 Get으로 변경함
                                          // Navigator.pushNamedAndRemoveUntil(
                                          //     context, '/login', (route) => false);
                                        },
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.black12),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30))),
                                            padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    const EdgeInsets.fromLTRB(
                                                        25, 0, 25, 0))),
                                        child: const Text(
                                          '로그아웃',
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 18,
                                              fontWeight: titleW),
                                        )))
                              ],
                            ),
                          )),
                    ),
                  ],
                ))
          ],
        ),
      );
    });
  }
}
