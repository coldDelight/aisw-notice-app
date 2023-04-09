import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hoseo_notice/models/mileage.dart';
import 'package:hoseo_notice/pages/mileage/mileage_controller.dart';
import 'package:hoseo_notice/pages/mileage/mileage_page.dart';

class MileageListItem extends StatelessWidget {
  final Mileage mileage;

  const MileageListItem({required this.mileage});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //마일리지 날짜
          Container(
            height: 25,
            child: Text(
              mileage.mileage_date,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xff5E5A57),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                //마일리지 제목
                child: Container(
                  // color: Colors.amber,
                  child: Text(
                    mileage.title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              //마일리지 점수
              Container(
                // color: Colors.cyan,
                // margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 20,
                      color: Color(0xffBD1824),
                    ),
                    Text(
                      mileage.program_mileage + "점",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          //리스트 사이에 구분선
          Container(
            child: Divider(
              color: Color(0xffD6DBDE),
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
