import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/pages/notice/notice_details.dart';
import 'package:hoseo_notice/themes/app_value.dart';

class HomeListItem extends StatelessWidget {
  final Notice homeNotice;

  const HomeListItem({required this.homeNotice});

  Widget build(BuildContext context){
    return Column(
      children: [
        TextButton(
          onPressed: (){
            Get.to(()=>NoticeDetails(homeNotice));
          },
          style: TextButton.styleFrom(primary: Colors.white),
          child: Container(
            margin: EdgeInsets.only(left: 13,right: 13, ),
            height: H*0.07,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height:19,
                  child: Text(
                    homeNotice.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color:Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    homeNotice.file != 0? Text(
                      "📎${homeNotice.file}개의 첨부파일",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ):const Text(""),
                    Row(
                      children: [
                        Text(
                          homeNotice.create_time,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 17,
                          color: Color(0xff5E5A57),
                        ),

                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),

              ],
            ),
          ),
        ),
        Container(
          child: const Divider(
            indent: 10,
            endIndent: 10,
            color: Color(0xffD6DBDE),
            thickness: 1,
          ),
        )
      ],
    );
  }
}
