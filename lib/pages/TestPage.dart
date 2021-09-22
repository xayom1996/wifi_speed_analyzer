import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/test_controller.dart';
import 'package:wifi_speed_analyzer/pages/components/speed_indicator.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final TestController testController = Get.find(tag: 'test');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Test',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        child: Center(
          child: Obx(() => AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: !testController.isPressed.value
                ? GestureDetector(
                  onTap: (){
                    testController.isPressed(true);
                  },
                  child: Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(250.sp),
                        // border: Border.all(color: Colors.grey[400], width: 2.sp),
                        color: mainColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(20, 151, 106, 0.5),
                            spreadRadius: 1,
                            blurRadius: 6, // changes position of shadow
                          ),
                        ],
                    ),
                    child: Center(
                        child: Text(
                          "Start".toUpperCase(),
                          // style: TextStyle(
                          //     fontSize: 34.sp,
                          //     fontWeight: FontWeight.w700
                          // ),
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 34.sp,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        )
                    ),
                  ),
              )
                : SpeedIndicator(),
          ),
          )
        ),
      ),
    );
  }

}