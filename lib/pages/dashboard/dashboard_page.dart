import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/dashboard/dashboard_controller.dart';
import 'package:hoseo_notice/themes/app_value.dart';

class DashboardPage extends StatelessWidget {
   const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppRatio().initWH(MediaQuery
        .of(context)
        .size
        .width, MediaQuery
        .of(context)
        .size
        .height);
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
        // 챗봇 임시 제거
          // floatingActionButton: controller.tabIndex==2? TextButton(
          //     onPressed: (){
          //       Get.to(const ChatBotPage());
          //     },
          //     style: TextButton.styleFrom(
          //         primary: Colors.white
          //     ),
          //     child: SvgPicture.asset(
          //       'images/Hoseo_Notice_chatbot.svg',
          //       width: 80,
          //       height:80,
          //     )
          // ):null,
          body: pageItem[controller.tabIndex],
          bottomNavigationBar: SizedBox(
            // height: H*AppRatio.bottomNaviSize,
            child: BottomNavigationBar(
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: bottomItem
            ),
          ),
        );
      },
    );
  }

}
