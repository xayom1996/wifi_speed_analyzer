import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/controllers/dashboard_controller.dart';
import 'package:wifi_speed_analyzer/controllers/history_controller.dart';
import 'package:wifi_speed_analyzer/controllers/home_controller.dart';
import 'package:wifi_speed_analyzer/controllers/scanning_controller.dart';
import 'package:wifi_speed_analyzer/controllers/settings_controller.dart';
import 'package:wifi_speed_analyzer/controllers/test_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(), tag: 'dashboard');
    Get.put<TestController>(TestController(), tag: 'test');
    Get.put<HistoryController>(HistoryController(), tag: 'history');
    Get.put<SettingsController>(SettingsController(), tag: 'settings');
    Get.put<ScanningController>(ScanningController(), tag: 'scanning');
  }
}