import 'package:flutter/material.dart';
import 'package:hoseo_notice/themes/app_value.dart';

ThemeData lightTheme = ThemeData(

  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: AppColor.mainColor,
    cursorColor: AppColor.cursorColor,
  ),

  //over 스크롤 색상
  colorScheme: ColorScheme.fromSwatch(
    accentColor: AppColor.scrollColor,
  ),

  //배경색상
  scaffoldBackgroundColor: AppColor.backGroundColor,
  backgroundColor: AppColor.backGroundColor,
  //하단 네비게이션 테마
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Color(0xffDBDFE2),
    selectedItemColor: Color(0xff5E5A57),
  ),
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,

  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
    color: Colors.white,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);
