import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/controllers/dashboard_controller.dart';
import 'package:wifi_speed_analyzer/controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(), tag: 'dashboard');
    Get.put<HomeController>(HomeController(), tag: 'home');
  }
}