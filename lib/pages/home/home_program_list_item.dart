import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/models/programs.dart';
import 'package:hoseo_notice/pages/notice/notice_details.dart';

class HomeProgramListItem extends StatelessWidget {
  final Programs homePrograms;

  const HomeProgramListItem({required this.homePrograms});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3),
      padding: EdgeInsets.only(top: 3, right: 3, bottom: 3, left: 3),
      decoration: BoxDecoration(
        color: const Color (0xffF5F4F2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.black
        ),
        onPressed: () {

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    homePrograms.program_state,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  decoration: BoxDecoration(
                      color: homePrograms.program_state == '모집 완료'
                          ? Color(0xffADADAD).withOpacity(0.4)
                          : homePrograms.program_state == '모집 중'
                          ? Color(0xffE7A6A6).withOpacity(0.6)
                          : Color(0xff7BB0FF).withOpacity(0.4)),
                ),
                Container(
                  child: Text(
                    homePrograms.mileage +"점",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10,),
              child: Text(
                homePrograms.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      homePrograms.startdate + " ~ " + homePrograms.enddate,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff5E5A57)
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
