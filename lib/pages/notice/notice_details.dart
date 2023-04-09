
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/pages/account/account_page.dart';
import 'package:hoseo_notice/pages/notice/notice_controller.dart';
import 'package:hoseo_notice/pages/notice/program_application.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/widget/loading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeDetails extends GetView<NoticeController> {
  final Notice notice;

  const NoticeDetails(this.notice, {Key? key}) : super(key: key);
  static const TextStyle noticeTitle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    controller.viewContent(notice.notice_id);
    return GetBuilder<NoticeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              '공지사항',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          body: Loading(
            isLoading: controller.isLoading,
            child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        //제목,작성자,작성일
                        Container(
                          width: W,
                          padding: const EdgeInsets.all(23),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notice.title, style: noticeTitle),
                              const SizedBox(height: 10),
                              Text(notice.create_time,
                                  style: const TextStyle(
                                      color: Color(0xff5E5A57),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                              Text(controller.noticeContent[0].name,
                                  style: const TextStyle(
                                      color: Color(0xff5E5A57),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        //내용,파일
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              width: W,
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Html(
                                    data: controller.noticeContent[0].content,
                                    customRender: {
                                      "table" : (context, child){
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: (context.tree as TableLayoutElement).toWidget(context),
                                        );
                                      }
                                    },
                                    onLinkTap: (url, _, __, ___) {
                                      _launchURL(url);
                                    },
                                    onImageTap: (url, _, __, ___) {

                                      final imgData = url;
                                      Get.to(Scaffold(
                                        appBar: AppBar(
                                          elevation: 0,
                                          backgroundColor: Colors.black,
                                          iconTheme: const IconThemeData(color: Colors.white60),
                                        ),
                                        body: PhotoView(
                                          loadingBuilder: (context, event) {
                                            return Container(
                                              color: Colors.black,
                                              child: const Center(
                                                  child: CircularProgressIndicator(color: AppColor.mainColor)),
                                            );
                                          },
                                          // imageProvider: NetworkImage(url!),
                                          // imageProvider: Image.memory(Uri.parse(imgData!).data!.contentAsBytes()).image,
                                          imageProvider: FadeInImage(
                                            image:Image.memory(Uri.parse(imgData!).data!.contentAsBytes()).image,
                                              placeholder: MemoryImage(kTransparentImage),
                                          ).image,
                                          minScale: PhotoViewComputedScale.contained * 0.8,
                                          maxScale: PhotoViewComputedScale.contained * 1.8,
                                        ),
                                      ));
                                    },
                                  ),
                                  for (var i = 0; i < notice.file; i++)
                                    ElevatedButton(
                                        onPressed: () {
                                          // controller.fileDown();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          onPrimary: Colors.grey[600],
                                          elevation: 1,
                                          primary: const Color(0xffD8D8D8),
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5, left: 10),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: RichText(
                                            maxLines: 1,
                                            text: TextSpan(children: [
                                              const WidgetSpan(
                                                  child: Icon(
                                                    Icons.folder_open,
                                                    size: 18,
                                                    color: Color(0xff5E5A57),
                                                  )),
                                              TextSpan(
                                                  text:
                                                  " ${controller.noticeContent[0].file![i]}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff4F4F4F),
                                                      fontWeight: FontWeight.w500))
                                            ]),
                                          ),
                                        ))
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
          bottomNavigationBar: notice.program_id != "null"
              ? SizedBox(
            height: H * 0.07,
            child: OutlinedButton(
              onPressed:
              controller.noticeContent[0].programState == "모집 중"
                  ? () {
                //프로그램이 모집중일때
                Get.dialog(ProgramApplicationDialog(
                    controller, notice.program_id));
              }
                  : null,
              child: controller.noticeContent[0].programState == "모집 중"
                  ? //프로그램이 모집중일때
              const Text(
                "신청하기",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )
                  : //프로그램이 모집중이 아닐때
              Text(
                '${controller.noticeContent[0].programState}',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              style: controller.noticeContent[0].programState == "모집 중"
                  ? //프로그램이 모집중일때
              ButtonStyle(
                shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15)))),
                overlayColor:
                MaterialStateProperty.all(Colors.black12),
                backgroundColor:
                MaterialStateProperty.all(AppColor.mainColor),
              )
                  : //프로그램이 모집중 아닐때
              ButtonStyle(
                  shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15)))),
                  backgroundColor: MaterialStateProperty.all(
                      AccountPage.arrowIconColor)),
            ),
          )
              : null,
        );
      },
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
