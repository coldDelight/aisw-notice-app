import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/firebase_options.dart';
import 'package:hoseo_notice/routes/app_pages.dart';
import 'package:hoseo_notice/routes/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:hoseo_notice/themes/app_theme.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/themes/user_info.dart';
import 'package:hoseo_notice/tool/user_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,//투명
  ));
  WidgetsFlutterBinding.ensureInitialized();

  firebaseSet();

  final token = await UserSecureStorage.getSecureValue(SCURE_JWT_KEY);

  if(token==null){//로그인 한번도 안한경우
    AppRoutes.START = "/login";
  }else{
    final tokenCheck = JwtDecoder.isExpired(token);
    if(tokenCheck){//토큰 유효기간 끝난경우
      AppRoutes.START = "/login";
    }else{
      AppRoutes.START = "/";
      setCookie(token);
      UserInfo(JwtDecoder.decode(token));//사용자정보
      UserInfo.accept = "동의";
      UserInfo.psuh_accept = (await UserSecureStorage.getSecureValue(SCURE_PUSH_KEY))!;// 푸쉬 동의
    }

  }

  // runApp( const MyApp()); // Wrap your app;

  runApp( DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      //화면별 확인 하기
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),


      // initialRoute: AppRoutes.DASHBOARD,
      initialRoute: AppRoutes.START, //로그인 여부에 따라 시작페이지로 이동
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,

    );
  }
}


void firebaseSet() async{
  try{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,//ios, android에 따라서 firebase init과정
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messaging.getToken().then((value) {
      FB_TOKEN = value!;
      // print("main.dart : FB device 토큰 ");
      // print(value);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // print("message recieved");
      // print(event.notification?.body);
      // print(event.data);
      // print(event.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // print('Message clicked!');
    });
  }catch(err){
    FB_TOKEN="err";
    print(err);
  }


}

