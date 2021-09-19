import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/theme/text_theme.dart';

class PlayListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find(tag: 'home');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text('Playlist', style: appBarTitle),
      ),
      body: Container(
        padding: EdgeInsets.all(8.sp),
      ),
    );
  }

}