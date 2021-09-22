import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class HistoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final HistoryController historyController = Get.find(tag: 'history');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'History',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Obx(() => Column(
          children: [
            for (var wifiSpeed in historyController.wifiSpeeds)
              Row(
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
                            wifiSpeed.downloadSpeed.toStringAsFixed(2),
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
                            wifiSpeed.uploadSpeed.toStringAsFixed(2),
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
          ],
        )),
      ),
    );
  }

}