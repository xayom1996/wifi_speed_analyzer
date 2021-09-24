import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/history_controller.dart';
import 'package:wifi_speed_analyzer/controllers/test_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/pages/TestPage.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class TestResultPage extends StatelessWidget{
  final TestController testController = Get.find(tag: 'test');
  final HistoryController historyController = Get.find(tag: 'history');

  @override
  Widget build(BuildContext context) {
    historyController.insertWifiSpeed(testController.downloadSpeed.value,
        testController.uploadSpeed.value);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Result',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: (){
            testController.uploadSpeed(0.0);
            testController.downloadSpeed(0.0);
            Navigator.pop(context);
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: mainColor,
            // #5B5B5B
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.circular(10.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    offset: Offset(12, 22),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Download'.toUpperCase(),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: mainColor1
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          FaIcon(
                            FontAwesomeIcons.chevronDown,
                            color: mainColor1,
                            // #5B5B5B
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            testController.downloadSpeed.value.toStringAsFixed(2),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Text(
                            'Mbps',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: mainColor
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Upload'.toUpperCase(),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: mainColor1
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          FaIcon(
                            FontAwesomeIcons.chevronUp,
                            color: mainColor1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            testController.uploadSpeed.value.toStringAsFixed(2),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Text(
                            'Mbps',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: mainColor
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}