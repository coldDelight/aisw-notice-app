import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/tool/api_request.dart';

class NoticeProvider {
  void getNoticeList({
    required Function() beforeSend,
    required Function(List<Notice> notice) onSuccess1,
    required Function(dynamic error) onError,
  }) {
    ApiRequest(url:"/notice/all_app").get2(
        beforeSend: () => { beforeSend()},
        onSuccess: (data) {
          onSuccess1(
              (data["Data"] as List).map((json) => Notice.fromJson(json)).toList());
        },
        onError: (error) => { onError(error)}
    );
  }
}

class NoticeContentProvider{
  void getNoticeContent({
    required Function() beforeSend,
    required Function(List<NoticeContent> notice) onSuccess1,
    required Function(dynamic error) onError,
    required int noticeId,
  }) {
    ApiRequest(url:"/notice/all_app/detail?notice_id=$noticeId").get2(
        beforeSend: () => { beforeSend()},
        onSuccess: (data) {
          onSuccess1(
              (data["Data"] as List).map((json) => NoticeContent.fromJson(json)).toList());
        },
        onError: (error) => {onError(error)}
    );
  }
}