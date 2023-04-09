import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/login/login_controller.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/tool/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    AppRatio().initWH(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return GetBuilder<LoginController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 학교 로고
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(W * 0.1, H * 0.1, W * 0.1, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/headerImg.png",
                            width: W * 0.7,
                          ),

                          // const Text(
                          //   '호서대학교',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w800,
                          //       fontSize: 35,
                          //       color: Colors.black87),
                          // ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: const <Widget>[
                          //     Text(
                          //       'SW',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.w900,
                          //         fontSize: 37,
                          //         color: AppColor.mainColor,
                          //       ),
                          //     ),
                          //     Text(
                          //       '중심대학사업단',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.w800, fontSize: 37),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    //학번 입력
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(W * 0.14, H * 0.09, W * 0.14, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '학번',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff5E5A57)),
                          ),
                          SizedBox(
                            height: H * 0.00246,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.people_alt_outlined),
                              SizedBox(
                                width: W * 0.0350,
                              ),
                              SizedBox(
                                  width: W * 0.6,
                                  height: H * 0.032,
                                  child: TextField(
                                    onChanged: (val) {
                                      controller.insert_id(val);
                                      // print('login_page : id input '+controller.id);
                                    },
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(top: -20),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: const Color(0xffA7A9AC),
                                  ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, H * 0.0086, 0, 0),
                              height: H * 0.001,
                              width: W * 0.7,
                              color: const Color(0xffA7A9AC)),
                        ],
                      ),
                    ),

                    //비밀번호 입력
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          W * 0.14, H * 0.02, W * 0.14, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '비밀번호',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff5E5A57)),
                          ),
                          SizedBox(
                            height: H * 0.00246,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(Icons.vpn_key_outlined),
                              SizedBox(
                                width: W * 0.0350,
                              ),
                              SizedBox(
                                  width: W * 0.6,
                                  height: H * 0.032,
                                  child: TextField(
                                    onChanged: (val) {
                                      controller.insert_pw(val);
                                    },
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(top: -20),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.text,
                                    cursorColor: const Color(0xffA7A9AC),
                                    obscureText: true,
                                  ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, H * 0.0086, 0, 0),
                              height: H * 0.001,
                              width: W * 0.7,
                              color: const Color(0xffA7A9AC)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.0377,
                    ),

                    //로그인 버튼
                    OutlinedButton(
                      onPressed: () {
                        controller.connectionType == 0
                            ? Get.snackbar('인터넷 연결 오류', '연결 상태를 확인하고 다시 시도해주세요',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red[400],
                                colorText: Colors.white,
                                duration: const Duration(seconds: 10))
                            : ApiRequest(url: "/auth/loginOracle", data: {
                                "user_id": controller.id,
                                "pwd": base64.encode(sha512
                                    .convert((utf8.encode(controller.pw)))
                                    .bytes)
                              }).post2(
                                onError: (err) {
                                  if (kDebugMode) {
                                    print(err);
                                  }
                                },
                                onSuccess: (data) {
                                  Auth().login(data,
                                      controller); // 로그인 함수 login api결과 & 컨트롤러
                                },
                                beforeSend: () {},
                              );
                      },
                      child: const Text("로그인"),
                      style: OutlinedButton.styleFrom(
                        primary: AppColor.mainColor,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                        side: BorderSide(
                            color: AppColor.mainColor, width: W * 0.0058),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        fixedSize: Size(W * 0.699999, 55),
                        backgroundColor: AppColor.backGroundColor,
                        elevation: 7.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
