import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/privacy_policy/privacy_policy_dialog.dart';
import 'package:hoseo_notice/routes/app_routes.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/themes/user_info.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/tool/user_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Auth {
  AlertDialog loginAlert(String errMessage){
    return AlertDialog(
      backgroundColor: const Color(0xffF5F4F2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: EdgeInsets.all(20),
      title: Column(
        children:  [
          Text(errMessage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          // const Text(
          //   '다시 입력해주세요.',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
      content: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            '다시 입력하기',
            style: TextStyle(
                color: Color(0xffBE1824),
                fontWeight: FontWeight.w800,
                fontSize: 16),
          )),
    );
  }
  Future<void> login(data, controller) async {
    final int type = data["type"];
    if(type ==1){//정상 로그인
      if (data["Data"]["accept"] == "미동의") {
        ApiRequest(url: PRODUCTION_URL + "/agreement/read_one").get2(
          // api로 가장 최근 개인정보 동의서 data 가지고 온다
          beforeSend: () => {},
          onSuccess: (res) async {
            Get.dialog(privacyPolicyDialog(
                true, res["Data"], data));
          },
          onError: (error) {},
        );
        //미동의한 경우 개인정보 동의서 표출
      } else {
        final token = data["Data"]["jwt_token"];
        setCookie(token); //api토큰설정
        UserSecureStorage.setJwt(token); //내부 저장소에 토큰 저장
        UserInfo(JwtDecoder.decode(token)); //사용자 정보 저장
        UserInfo.accept = "동의"; //개인정보동의
       final push = await UserSecureStorage.getSecureValue(SCURE_PUSH_KEY);
        if (push==null){
          UserInfo.psuh_accept ="동의";
          UserSecureStorage.setSecureValue(SCURE_PUSH_KEY,"동의");
          ApiRequest(
              url: PRODUCTION_URL +
                  "/auth/push-message",
              data: {
                "active": UserInfo.psuh_accept,
                "device_token": FB_TOKEN
              }).put2(
              beforeSend: () {},
              onSuccess: (data) {
              },
              onError: (err) {});
        }else{
          UserInfo.psuh_accept = push;
        }
        Get.offAllNamed(AppRoutes.DASHBOARD);
      }
    }else if(type==2){//비밀번호 틀림
      Get.dialog(
        loginAlert(data["Error_Message"]),
      );
    }else if(type==3){//학번 or 포털 sw 개인정보 동의X
      Get.dialog(
        loginAlert(data["Error_Message"]),
      );
    }else{// ????
      Get.dialog(
        loginAlert(data["Error_Message"]),
      );
    }
  }

  void logout() {
    UserSecureStorage.delSecureValue(SCURE_JWT_KEY); // 내부 저장소 jet 값 삭제
    AppRoutes.START = "/login"; //로그인으로 route 변경
    delCookie(); //쿠키 삭제
    Get.offAndToNamed(AppRoutes.START); //이동
  }
}
