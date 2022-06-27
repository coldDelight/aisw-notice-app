import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'notice_controller.dart';
import 'notice_details.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var points = [
      Offset(size.width - (size.width / 4), 0), // point p1
      Offset(0, size.height - (size.height / 4)), // point p2
      Offset(0, size.height), // point p3
      Offset(size.width, 0) // point p4
    ];
    Path path = Path()
      ..addPolygon(points, false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
    throw UnimplementedError();
  }
}

class NoticeListItem extends StatelessWidget {
  final Notice notice;
  final NoticeController con;
  const NoticeListItem({required this.notice, required this.con});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.focusScope!.unfocus();
        Get.to(()=>NoticeDetails(notice))?.then((value) => con.closeDetail());
      },
      style: TextButton.styleFrom(padding: const EdgeInsets.fromLTRB(0,0, 10, 0)),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColor.cardBackgroundColor,
            border: Border(
                bottom: BorderSide(width: 1, color: Color(0xffD6DBDE)))),
        child: Column(
          children: [
            Row(
              children: [
              //   ClipPath(
              //   child: blueBox(),
              //   clipper: MyCustomClipper(),
              // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10),
                  child: SizedBox(
                    width: W*0.87,
                    child: Text(
                      notice.title,
                      maxLines: 2,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                ),
              ],
            ),
            // Row(children: [
            //   Expanded(
            //     child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             notice.title,
            //             maxLines: 2,
            //             softWrap: true,
            //             style: const TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w700,
            //                 color: Color(0xff000000)),
            //           ),
            //         ]),
            //   ),
            // ]),
            SizedBox(height: H * 0.035),
            Container(
              padding: const EdgeInsets.only(left: 30),
              child: Row(children: [
                Expanded(
                  child: notice.file == 0
                      ? const Text("")
                      : RichText(
                    text: TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                            Icons.folder_open,
                            size: 14,
                            color: Color(0xff5E5A57),
                          )),
                      TextSpan(
                        text: "${notice.file}개의 첨부파일",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff5E5A57)),
                      )
                    ]),
                  ),
                ),
                RichText(
                  text: TextSpan(children: [
                    const WidgetSpan(
                        child: Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Color(0xff5E5A57),
                        )),
                    TextSpan(
                      text: " ${notice.create_time}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff5E5A57)),
                    )
                  ]),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Color(0xff5E5A57)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return TextButton(
  //     onPressed: () {
  //       Get.focusScope!.unfocus();
  //       Get.to(NoticeDetails(notice));
  //     },
  //     style: TextButton.styleFrom(primary: Colors.black12),
  //     child: Container(
  //       decoration: const BoxDecoration(
  //           color: Colors.redAccent,
  //           border: Border(
  //               bottom: BorderSide(width: 1, color: Color(0xffD6DBDE)))),
  //       child: Column(
  //         children: [
  //           Row(children: [
  //             Expanded(
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       notice.title,
  //                       maxLines: 2,
  //                       softWrap: true,
  //                       style: const TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w700,
  //                           color: Color(0xff000000)),
  //                     ),
  //                   ]),
  //             ),
  //           ]),
  //           SizedBox(height: H * 0.035),
  //           Container(
  //             margin: const EdgeInsets.only(left: 15),
  //             child: Row(children: [
  //               Expanded(
  //                 child: notice.file == 0
  //                     ? const Text("")
  //                     : RichText(
  //                   text: TextSpan(children: [
  //                     const WidgetSpan(
  //                         child: Icon(
  //                           Icons.folder_open,
  //                           size: 14,
  //                           color: Color(0xff5E5A57),
  //                         )),
  //                     TextSpan(
  //                       text: "${notice.file}개의 첨부파일",
  //                       style: const TextStyle(
  //                           fontWeight: FontWeight.w400,
  //                           fontSize: 12,
  //                           color: Color(0xff5E5A57)),
  //                     )
  //                   ]),
  //                 ),
  //               ),
  //               RichText(
  //                 text: TextSpan(children: [
  //                   const WidgetSpan(
  //                       child: Icon(
  //                         Icons.calendar_today,
  //                         size: 14,
  //                         color: Color(0xff5E5A57),
  //                       )),
  //                   TextSpan(
  //                     text: " ${notice.create_time}",
  //                     style: const TextStyle(
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: 12,
  //                         color: Color(0xff5E5A57)),
  //                   )
  //                 ]),
  //               ),
  //               const Icon(Icons.arrow_forward_ios,
  //                   size: 18, color: Color(0xff5E5A57)),
  //             ]),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  SizedBox blueBox() {
    return SizedBox(
      child: Container(
        color: notice.priority == 1
            ? AppColor.mainColor
            : AppColor.cardBackgroundColor,
      ),
      width: 20,
      height: 25,
    );
  }
}
