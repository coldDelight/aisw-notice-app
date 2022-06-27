import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/home/home_notice_list_item.dart';
import 'package:hoseo_notice/pages/notice/notice_page.dart';
import 'package:hoseo_notice/themes/app_value.dart';
import 'package:hoseo_notice/widget/loading.dart';
import 'home_controller.dart';
import 'home_program_list_item.dart';
class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  Column topText(){
    return Column(
      children: [
        Center(child: Image.asset("images/headerImg.png",width: W*0.8,)),
      ],
    );
  }
  Container topCircle(){
    return Container(
      height: H*0.27,
      width: W*0.5,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffC4C4C4)
      ),
    );
  }
  Column topMileageScore(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                    height: H*0.04,
                    width: W*0.3,
                  )
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: W*0.22,
                  height: 6,
                  color: Color(0xffE7A6A6),
                ),
              ),
               Positioned(
                top: 0,
                left: 10,
                child: Text(
                  "적립 마일리지",
                  style: TextStyle(
                      fontSize: W*0.04,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff5E5A57)
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: W*0.45,
              height: H*0.09,
              decoration: const BoxDecoration(
                  color: Color(0xffDF3B3B),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(29),
                    bottomRight: Radius.circular(29),
                  )
              ),
              child:  Center(
                child: Text(
                  (controller.nowmileage).toString()+'점',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: W*0.09,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: W*0.59,
                        ),
                        Positioned(
                          top: W * 0.04,
                            right: -W*0.2,
                            child: topCircle()
                        ),
                        Container(
                          child: topText(),
                        ),
                        Positioned(
                          top: W*0.3,
                          child: topMileageScore(),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(left:10,right:10,bottom: 10,top: 10),
                        height: H*0.40,
                        decoration: const BoxDecoration(
                          color: Color (0xffF5F4F2),
                          borderRadius: BorderRadius.all(Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                              height: H * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "공지사항",
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(
                                         const NoticePage()
                                        ); //공지페이지로 가기
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xffC4C4C4),
                                          primary: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)
                                              )
                                          )
                                      ),
                                      child: const Text(
                                        "더보기",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 15,right: 15,),
                                height: H * 0.4,
                                child: Loading(
                                  isLoading: controller.isLoading,
                                  child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder: (BuildContext context,
                                          int index) =>
                                          HomeListItem(
                                              homeNotice: controller
                                                  .homeNoticeList[index]
                                          )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   child: IconButton(
                    //     icon: controller.eventImage,
                    //     onPressed: (){
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 10,right: 10),
                    //   child: IconButton(
                    //     icon: ApiRequest(url: PRODUCTIOM_URL + "/notice/download?file_name=event1.png",data: ),
                    //     onPressed: (){},
                    //   ),
                    // ),

                    // Stack(
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    //       child: TextButton(
                    //         style: TextButton.styleFrom(
                    //             backgroundColor: Colors.white,
                    //           primary: Colors.white
                    //         ),
                    //         onPressed: () {
                    //           null;
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment
                    //               .spaceAround,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment
                    //                   .start,
                    //               mainAxisAlignment: MainAxisAlignment
                    //                   .spaceEvenly,
                    //               children: [
                    //                 const Text(
                    //                   "매주 공개되는",
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.w700,
                    //                       color: Colors.black
                    //                   ),
                    //                 ),
                    //                 Row(
                    //                   children: const[
                    //                     Text(
                    //                       "소중한 퀴즈 풀면 ",
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w700,
                    //                           color: Colors.black
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       "선물",
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w700,
                    //                           color: Color(0xffE52106)
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       " 증정!",
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w700,
                    //                           color: Colors.black
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //                 Text(
                    //                   "2022-01-27~2022-02-29",
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.w700,
                    //                       fontSize: 9,
                    //                       color: Color(0xffC4C4C4)
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             Image.asset(
                    //               'images/Hoseo_Notice_gift.png',
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //         left: 40,
                    //         child: Container(
                    //           width: 62,
                    //           height: 15,
                    //           color: Color(0xffFEE7AB),
                    //           child: Text(
                    //             " EVENT!",
                    //             style: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w700
                    //             ),
                    //           ),
                    //         )
                    //     )
                    //   ],
                    // ),

                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 15,right: 15),
                      child: const Text(
                        '프로그램 신청',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: CarouselSlider.builder(
                        itemCount: controller.programList.length,
                        itemBuilder: (context, index, realIndex) => HomeProgramListItem(homePrograms: controller.programList[index]),
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}


