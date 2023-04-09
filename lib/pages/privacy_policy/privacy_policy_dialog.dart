import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/routes/app_routes.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/themes/user_info.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:hoseo_notice/tool/user_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


Dialog privacyPolicyDialog(isLoginPage,data,userData){
  return Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    child: SingleChildScrollView(
      child: SizedBox(
        height: H * 0.55,
        width: W * 0.81,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(1, 33, 1, 10),
              child: Center(
                child: Text("개인정보 처리방침",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  Html(data: data["content"]),
                ],
              ),
            ),
            isLoginPage ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(
                  height: 0, thickness: 1, color: Color(0xffC4C4C4),),
                SizedBox(
                  height: H * 0.075,
                  width: W * 0.81,
                  child: TextButton(
                    onPressed: () {
                      ApiRequest(url:"/auth/check_accept",
                          data: {
                            "user_id": UserInfo.user_id,
                            "agreement_id": data["agreement_id"]
                          }).post2(
                          onError: (err) {
                            print(err);
                          },
                          onSuccess: (data) {
                            String token = userData["Data"]["jwt_token"];
                            UserSecureStorage.setJwt(token);//내부 저장소에 토큰 저장
                            UserInfo(JwtDecoder.decode(token)); //사용자 정보 저장
                            UserInfo.accept="동의";
                            UserInfo.psuh_accept="동의";
                            setCookie(token); //api토큰설정
                            UserSecureStorage.setSecureValue(SCURE_PUSH_KEY,"동의");//내부 저장소에 토큰 저장
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

                            Get.offAllNamed(AppRoutes.DASHBOARD);
                          }, beforeSend: () {}

                      );
                    },
                    style: TextButton.styleFrom(primary: Color(0xffB3282D)),
                    child: const Text("동의",
                      style: TextStyle(
                        color: Color(0xffB3282D),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                )
              ],
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(
                  height: 0, thickness: 1, color: Color(0xffC4C4C4),),
                SizedBox(
                  height: H * 0.075,
                  width: W * 0.81,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(primary: Color(0xffC4C4C4)),
                    child: const Text("닫기",
                      style: TextStyle(
                        color: Color(0xff5E5A57),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
//기존 코드
// Dialog privacyPolicyDialog(isLoginPage){
//   return Dialog(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20.0))
//     ),
//     child: SingleChildScrollView(
//       child: Container(
//         height: H*0.55,
//         width: W*0.81,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const Padding(
//               padding: EdgeInsets.fromLTRB(1, 33, 1, 10),
//               child: Center(
//                 child: Text("개인정보 처리방침",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               height: H*0.38,
//               width: W*0.71,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Text(
//                       '1. 수집하는 개인정보\n\n'
//                       '회사는 이용자(회원, 비회원 포함)로부터 서비스 이용을 위해 필요한 최소한의 개인정보를 수집하여 처리하고 있습니다.\n'
//                       '아이디(이메일 주소), 비밀번호, 이름(닉네임)을 필수항목으로 수집하며, 사진(메타정보 포함), 휴대폰번호, 지역(구단위) 정보를 선택적으사는 이용자(회원, 비회원 포함)로부터 서비스 이용을 위해 필요한 최소한의 개인정보를 수집하여 처리하고 있습니다.사는 이용자(회원, 비회원 포함)로부터 서비스 이용을 위해 필요한최소한의 개인정보를 수집하여 처리하고 있습니다.\n\n' * 30,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             isLoginPage ? Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Divider(height: 0,thickness: 1,color: Color(0xffC4C4C4),),
//                 SizedBox(
//                   height: H*0.075,
//                   width: W*0.81,
//                   child: TextButton(
//                     onPressed: (){
//                       Get.offAllNamed(AppRoutes.DASHBOARD);
//                     },
//                     style: TextButton.styleFrom(primary: Color(0xffB3282D)),
//                     child: const Text("동의",
//                       style: TextStyle(
//                         color: Color(0xffB3282D),
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),),
//                   ),
//                 )
//               ],
//             ): Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Divider(height: 0,thickness: 1,color: Color(0xffC4C4C4),),
//                 SizedBox(
//                   height: H*0.075,
//                   width: W*0.81,
//                   child: TextButton(
//                     onPressed: (){
//                       Get.back();
//                     },
//                     style: TextButton.styleFrom(primary: Color(0xffC4C4C4)),
//                     child: const Text("닫기",
//                       style: TextStyle(
//                         color: Color(0xff5E5A57),
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }