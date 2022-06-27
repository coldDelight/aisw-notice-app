import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hoseo_notice/themes/app_value.dart';


AppBar mainAppbar(String title) {
  return AppBar(
    elevation: 1,
    title: Container(
      padding: const EdgeInsets.only(left: 10),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w800)),
          Image.asset("images/headerImg.png",width: W*0.3,)
        ],
      ),
    ),
    backgroundColor: AppColor.cardBackgroundColor,
    // foregroundColor: textColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5),
        )),
  );
}

AppBar noticeAppbar(title,controller) {
  return AppBar(
    elevation: 1,
    title: GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Text('공지사항',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
                Image.asset("images/headerImg.png",width: W*0.3,),
              ],
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                  color: Color(0xfff5f4f2),
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10))),
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        onChanged: (val) {
                          controller.inputWord(val);
                          if (kDebugMode) {
                            print('notice_page : word input ' +
                              controller.searchWord);
                          }
                        },
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: -10.0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColor.mainColor),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColor.mainColor),
                                borderRadius: BorderRadius.circular(30)),
                            suffixIcon: const Icon(Icons.search,color: AppColor.mainColor,)),
                        keyboardType: TextInputType.text,
                      ),
                      height: 36,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: AppColor.mainColor,
                            value: controller.searchProgram,
                            shape:
                            const CircleBorder(side: BorderSide.none),
                            checkColor: const Color(0xffD1D1D1),
                            onChanged: (value) {
                              print(value);
                              controller.checkProgram(value!);
                            }),
                        const Text(
                          "프로그램 관련 공지만 보기",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    ),
    backgroundColor: const Color(0xffF5F4F2),
    foregroundColor: Colors.black,
    toolbarHeight: 155,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
  );
}