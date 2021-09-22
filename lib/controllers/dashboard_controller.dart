import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/pages/HistoryPage.dart';
import 'package:wifi_speed_analyzer/pages/TestPage.dart';
import 'package:wifi_speed_analyzer/pages/homePage.dart';
import 'package:wifi_speed_analyzer/pages/playListPage.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find(tag: 'dashboard');
  var tabIndex = 0.obs;
  List<Widget> pages;

  @override
  void onInit(){
    pages = [
      TestPage(),
      HistoryPage(),
      Container(),
      Container(),
    ];
    super.onInit();
  }

  Widget get currentPage => pages[tabIndex.value];

  void changeTabIndex(int index) async {
      print(index);
      tabIndex.value = index;
  }
}