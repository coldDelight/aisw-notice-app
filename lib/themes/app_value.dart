import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoseo_notice/common/custom_icons_icons.dart';
import 'package:hoseo_notice/pages/account/account_page.dart';
import 'package:hoseo_notice/pages/home/home_page.dart';
import 'package:hoseo_notice/pages/mileage/mileage_page.dart';
import 'package:hoseo_notice/pages/note/note_page.dart';
import 'package:hoseo_notice/pages/notice/notice_page.dart';

var W=0.0;
var H=0.0;
const TEST_URL = "http://210.119.104.203:3000";
const PRODUCTION_URL = "https://swnotice.hsu.ac.kr/api";
var _JWT = "";

const SCURE_JWT_KEY = "jwt";// 내부저장소 jwt 키값
const SCURE_PUSH_KEY = "push";//내부저장소 push값

var FB_TOKEN = "";
const APP_VERSION = "1.0.0";

List<BottomNavigationBarItem> bottomItem = [
  _bottomNavigationBarItem(
    icon: CupertinoIcons.zoom_in,
    label: '공지',
  ),
  _bottomNavigationBarItem(
    icon: CupertinoIcons.bell,
    label: '알림',
  ),
  _bottomNavigationBarItem(
    icon: CupertinoIcons.home,
    label: '홈',
  ),
  _bottomNavigationBarItem(
    icon: CustomIcons.mileage,
    label: '마일리지',
  ),
  _bottomNavigationBarItem(
    icon: CupertinoIcons.person,
    label: '내정보',
  ),
];
String getCookie(){
  return _JWT;
}

void setCookie(String? jwt){
  _JWT = "student="+jwt!;
}
void delCookie(){
  _JWT = "";
}


List<Widget> pageItem = const [
  NoticePage(),
  NotePage(),
  HomePage(),
  MileagePage(),
  AccountPage()
];

_bottomNavigationBarItem({required IconData icon, required String label}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}

class AppColor {
  static const cursorColor =  Color(0xffA7A9AC);
  static const backGroundColor = Color(0xffEDEDED);
  static const mainColor = Color(0xffB3282D);
  static const appbarTextColor = Color(0xffB3282D);
  static const cardBackgroundColor = Color(0xffF5F4F2);
  static const scrollColor = Colors.grey;

}

class AppRatio{

  initWH(w,h){
    W = w;
    H = h;
  }
}

