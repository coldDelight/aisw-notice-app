
enum ChatChatBotType { text, image }

class ChatBot {
  late String text;
  late String chatBotType;
  late bool isSender;

  ChatBot(
    this.text,
    this.chatBotType,
    this.isSender,
  );
}
