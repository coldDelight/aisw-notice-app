import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/models/note.dart';
import 'note_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class NoteListItem extends GetView<NoteController> {
  final NoteController con;

  final idx;

  final Note note;

  const NoteListItem(
      {required this.note, required this.con, required this.idx});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(builder: (con) {
      return Card(
        color: note.tileColor,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //알림 날짜
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    //color: Colors.amber,
                    child: Text(
                      note.push_time,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff5E5A57),
                      ),
                    ),
                  ),
                ],
              ),
              //알림 제목
              Container(
                //color: Colors.cyan,
                margin: EdgeInsets.only(bottom: 7, top: 4),
                child: Text(
                  note.push_title,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          //알림 내용
          subtitle: Container(
            margin: EdgeInsets.only(left: 15, bottom: 4),
            child: SelectableLinkify(
              onOpen: _onOpen,
              text: note.push_content,
            ),
          ),
          onTap: () {
            //타일 선택 되었을때 색깔 변경
            if (con.isselButtonClicked) {
              if (note.is_sel) {
                note.tileColor = Colors.white;
                controller.tileTab(idx, false);
              } else {
                note.tileColor = Color(0xffCBCBCB);
                controller.tileTab(idx, true);
              }
              note.is_sel = !note.is_sel;
              con.update();
              con.trashButtonAct();
              //print(idx);
            }
          },
        ),
      );
    });
  }

  //urllauncher
  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
