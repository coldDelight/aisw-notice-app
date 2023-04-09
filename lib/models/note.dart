import 'package:flutter/material.dart';

class Note {
  late String push_title;
  late String push_content;
  late String push_time;
  late String user_push_id;
  late Color tileColor;
  late bool is_sel;
  //late String isChecked;

  Note(this.push_title, this.push_content, this.push_time, this.user_push_id);

  Note.fromJson(Map<String, dynamic> json) {
  push_title = json['push_title'];
  push_content = json['push_content'];
  push_time = json['push_time'];
  user_push_id = json['user_push_id'].toString();
  tileColor = Colors.white;
  is_sel = false;
}

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['push_title'] = push_title;
  data['push_content'] = push_content;
  data['push_time'] = push_time;
  data['user_push_id'] = user_push_id;
  return data;
  }
}