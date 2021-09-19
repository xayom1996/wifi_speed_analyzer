import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/controllers/home_controller.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';
import 'package:wifi_speed_analyzer/theme/text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find(tag: 'home');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        ],
      ),
    );
  }
}