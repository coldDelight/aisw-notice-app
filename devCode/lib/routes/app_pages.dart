import 'package:get/get.dart';
import 'package:hoseo_notice/pages/dashboard/dashboard_binding.dart';
import 'package:hoseo_notice/pages/dashboard/dashboard_page.dart';
import 'package:hoseo_notice/pages/login/login_binding.dart';
import 'package:hoseo_notice/pages/login/login_page.dart';
import 'package:hoseo_notice/routes/app_routes.dart';

class AppPages{
  static var list = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: ()=> const DashboardPage(),
      binding: DashboardBinding(),
    ),GetPage(
      name: AppRoutes.LOGIN,
      page: ()=>  const LoginPage(),
      binding:  LoginBinding()
    ),

  ];
}