import 'dart:convert';
class Notice {
  late String notice_id;
  late String title;
  late String? program_id;
  late int priority;
  late String create_time;
  late int file;

  Notice({required this.notice_id, required this.title, required this.priority,
    required this.create_time,  required this.file,required this.program_id});

   Notice.fromJson(Map<String, dynamic> json) {
    notice_id= json['notice_id'].toString();
    title= json['title'];
    priority= json['priority'];
    create_time = json['create_time'];
    program_id = json['program_id'].toString();
    file = json['file_count'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notice_id'] = notice_id;
    data['title'] = title;
    data['priority'] = priority;
    data['create_time'] = create_time;
    data['file_count'] = file;
    return data;
  }
}

class NoticeContent{
  late String name;
  late String content;
  late List<String>? file;
  late String? DEPT_NM;
  late String? programState;

  NoticeContent({ required this.name, required this.content, required this.file, required this.DEPT_NM,required this.programState});

  NoticeContent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if(json['file']!=null)file= (jsonDecode(json['file']) as List<dynamic>).cast<String>();
    content = json['content'];
    DEPT_NM=json['department'];
    programState=json['program_state'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name']=name;
    data['file'] = file;
    data['content']=content;
    data['DEPT_NM']=DEPT_NM;
    data['programState']=programState;
    return data;
  }
}

