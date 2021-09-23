import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/pages/components/custom_dialog.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';
import 'package:intl/intl.dart';

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
        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CustomDialog(
                        action: (){
                          historyController.deleteAll();
                        },
                      )
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.trash,
              color: Color(0xff4A5967),
              // #5B5B5B
            ),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            for (var wifiSpeed in historyController.wifiSpeeds)
              Padding(
                padding: EdgeInsets.all(18.sp),
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      color: Color(0xff181818),
                      borderRadius: BorderRadius.circular(8.sp),
                      // border: Border.all(color: Colors.blueAccent)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date'.toUpperCase()),
                                Text(DateFormat('dd/MM/yyyy').format(wifiSpeed.createdAt)),
                                Text(DateFormat('HH:mm').format(wifiSpeed.createdAt)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Download'.toUpperCase()),
                                Text(wifiSpeed.downloadSpeed.toStringAsFixed(2)),
                                Text('Mbps'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Upload'.toUpperCase()),
                                Text(wifiSpeed.uploadSpeed.toStringAsFixed(2)),
                                Text('Mbps'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.sp),
                            bottomRight: Radius.circular(8.sp),
                          ),
                        ),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('WIFI NAME: ${wifiSpeed.isp.toString()}'),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              )
              /*Row(
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
                            'Mbps ${wifiSpeed.isp}',
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
              ),*/
          ],
        ),
      )),
    );
  }

}