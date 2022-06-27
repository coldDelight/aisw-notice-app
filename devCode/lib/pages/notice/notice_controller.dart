import 'dart:io';

import 'package:get/get.dart';
import 'package:hoseo_notice/models/notice.dart';
import 'package:hoseo_notice/pages/notice/notice_provider.dart';
import 'package:hoseo_notice/tool/api_request.dart';
import 'package:path_provider/path_provider.dart';

class NoticeController extends GetxController {

  static const title = "공지사항";
  var searchWord = "";
  List<Notice> noticeList = [];
  List<Notice> data = [];
  List<NoticeContent> noticeContent = [NoticeContent(name:"",content: "", file: ["","","","",""], DEPT_NM: '',programState: '')];
  bool searchProgram = false;
  bool isLoading = true;

  @override
  void onInit() {
    NoticeProvider().getNoticeList(
        beforeSend: () {},
        onSuccess1: (notice) {
          data.addAll(notice);
          noticeList = data;
          isLoading = false;
          filtering();
        },
        onError: (error) {
          isLoading = false;
          print(error);
          update();
          print("Notice Error");
        });
    super.onInit();
  }

  void closeDetail() {
    noticeContent = [NoticeContent(name:"",content: "", file: ["","","","",""], DEPT_NM: '',programState: '')];
  }

  void viewContent(String noticeId) {
    isLoading=true;
    NoticeContentProvider().getNoticeContent(
        beforeSend: (){},
        onSuccess1: (content){
          noticeContent=[];
          noticeContent.addAll(content);
          isLoading=false;
          update();
        },
        onError: (error) {
          isLoading = false;
          print(error);
          update();
          print("NoticeContent Error");
        },
        noticeId: int.parse(noticeId));
  }

  void inputWord(String searchWord) {
    this.searchWord = searchWord;
    filtering();
  }

  void checkProgram(bool check) {
    searchProgram = check;
    filtering();
  }

  void filtering(){
    if(searchProgram){
      List<Notice>tmp = data.where((i)=> i.program_id!="null").toList();
      if (searchWord == "") {
        noticeList = tmp;
      }
      else {
        noticeList = tmp.where((i) =>
            i.title.toLowerCase().contains(searchWord.toLowerCase())).toList();
      }
    }
    else{
      if (searchWord == "") {
        noticeList = data;
      }
      else {
        noticeList = data.where((i) =>
            i.title.toLowerCase().contains(searchWord.toLowerCase())).toList();
      }
    }
    update();
  }

  void fileDown(){

    ApiRequest(url:"/notice/download?file_name=testfile.pdf").get2(
      beforeSend: () => {},
      onSuccess: (data) async{
        const filename = 'file.txt';
        var file = await File(filename).writeAsString('some content');
        print(file);
        // print(data);
      },
      onError: (error) => {},
    );

  }
  Future<String> _localPath() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    return appDocPath;
  }


  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // 파일 쓰기
    return file.writeAsString('$counter');
  }


}

