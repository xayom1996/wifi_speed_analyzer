import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wifi_speed_analyzer/controllers/history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/models/wifi_speed.dart';
import 'package:wifi_speed_analyzer/pages/components/custom_dialog.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class HistoryDetailPage extends StatelessWidget{
  final WifiSpeed wifiSpeed;

  const HistoryDetailPage({Key key, this.wifiSpeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryController historyController = Get.find(tag: 'history');

    void onExit(){
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          DateFormat('dd.MM, hh:mma').format(wifiSpeed.createdAt).toLowerCase(),
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: (){
            onExit();
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: mainColor,
            size: 16.sp,
            // #5B5B5B
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
                          historyController.delete(wifiSpeed);
                          onExit();
                        },
                      )
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.trash,
              color: Color(0xff4A5967),
              size: 16.sp,
              // #5B5B5B
            ),
          ),
        ],
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
                    offset: Offset(0, 12.h),
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
                            size: 16.sp,
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
                            size: 16.sp,
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
            ),
            SizedBox(
              height: 17.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.circular(8.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    offset: Offset(0, 12.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icons/language.svg',
                            color: Color(0xffBDBDBD),
                            height: 20.h,
                            width: 20.w,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ISP',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffBDBDBD),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              wifiSpeed.isp,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/wifi.svg',
                          color: Color(0xffBDBDBD),
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Wifi-Name',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              wifiSpeed.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location_on.svg',
                          color: Color(0xffBDBDBD),
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'IP Address',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              wifiSpeed.ipAddress,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/computer.svg',
                          color: Color(0xffBDBDBD),
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Server',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              wifiSpeed.server,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/phone_iphone.svg',
                          color: Color(0xffBDBDBD),
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Device',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffBDBDBD),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              wifiSpeed.device,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}