import 'package:get/get.dart';
import 'package:hoseo_notice/models/chatbot.dart';

// import 'chatbot_list_item.dart';

class ChatBotController extends GetxController {
  List<ChatBot> chatbotList = [];

  var message = "";

  void insert_message(String message) {
    this.message = message;
    update();
  }
}
