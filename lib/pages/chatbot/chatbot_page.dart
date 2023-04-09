import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoseo_notice/pages/chatbot/chatbot_controller.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatBotController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '소중톡',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                //color: Colors.red,
                child: Column(
                  children: [
                    const Text(
                      '안녕하세요! ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'AI 챗봇',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              bottom: 3,
                              left: 5,
                              child: Container(
                                width: 50,
                                height: 7,
                                color: const Color(0xffE7A6A6),
                              ),
                            ),
                            const Text(
                              ' 소중톡',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19),
                            ),
                          ],
                        ),
                        const Text(
                          '입니다.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    const Text(
                      '궁금한 점은 언제든 저에게 물어보세요!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.deepPurple,
                  child: ListView(
                    children: [
                      Text(controller.message),
                    ],
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 20),
                color: Colors.white,
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xffD6DBDE),
                      width: 2,
                    ),
                    color: const Color(0xffF5F4F2),
                  ),
                  child: TextField(
                    onChanged: (val) {
                      controller.insert_message(val);
                    },
                    decoration: InputDecoration(
                      hintText: '   여기에 입력하세요',
                      //hintText
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print(controller.message);
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_circle_up_sharp,
                          color: Color(0xffDF3B3B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
