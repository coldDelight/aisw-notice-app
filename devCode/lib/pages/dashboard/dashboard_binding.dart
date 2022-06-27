import 'package:get/get.dart';
import 'package:hoseo_notice/pages/account/account_controller.dart';
import 'package:hoseo_notice/pages/chatbot/chatbot_controller.dart';
import 'package:hoseo_notice/pages/home/home_controller.dart';
import 'package:hoseo_notice/pages/mileage/mileage_controller.dart';
import 'package:hoseo_notice/pages/my_program/my_program_controller.dart';
import 'package:hoseo_notice/pages/note/note_controller.dart';
import 'package:hoseo_notice/pages/notice/notice_controller.dart';
import 'package:hoseo_notice/pages/notice/program_application.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
    Get.lazyPut<NoteController>(() => NoteController(),fenix: true);
    Get.lazyPut<NoticeController>(()=>NoticeController(),fenix: true);
    Get.lazyPut<MileageController>(() => MileageController(),fenix: true);
    Get.lazyPut<MyProgramController>(() => MyProgramController(),fenix: true);
    Get.lazyPut<AccountController>(() => AccountController(),fenix: true);
    // Get.lazyPut<ChatBotController>(() => ChatBotController(),fenix: true);
    Get.lazyPut<ProgramApplication>(() => ProgramApplication(),fenix: true);
  }
}
