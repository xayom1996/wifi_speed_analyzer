import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/scanning_controller.dart';
import 'package:wifi_speed_analyzer/controllers/test_controller.dart';
import 'package:wifi_speed_analyzer/pages/TestResultPage.dart';
import 'package:wifi_speed_analyzer/pages/components/speed_indicator.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class ScanningRoutes {
  static const String ScanningPage = 'scanning';
  static const String ResultPage = 'result';
}

class ScanningNavigator extends StatelessWidget{
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState.canPop();
        if (canPop) {
          navigatorKey.currentState.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: ScanningRoutes.ScanningPage,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case ScanningRoutes.ScanningPage:
              builder =
                  (BuildContext _) => ScanningPage();
              break;
            case ScanningRoutes.ResultPage:
              builder =
                  (BuildContext _) => ScanningResultPage();
              break;
          }

          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}

class ScanningPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final ScanningController scanningController = Get.find(tag: 'scanning');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Scanning',
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
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
        child: Center(
          child: Obx(() => scanningController.isLoading.value
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/иконка.svg',
                      height: 0.4.sh,
                    ),
                    Text(
                      'Analyzing the hosts in your network',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.sp),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        padding: EdgeInsets.all(16.sp),
                        onPressed: (){
                          scanningController.isLoading(true);
                          Timer(const Duration(seconds: 1), () {
                            Navigator.pushNamed(context, ScanningRoutes.ResultPage);
                            scanningController.isLoading(false);
                          });
                        },
                        color: mainColor,
                        child: Text(
                          'Start the scanning',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          )
        ),
      ),
    );
  }

}

class ScanningResultPage extends StatelessWidget{
  final List<Map> scanningList = [
    {
      'ipAddress': '172.16.254.178',
      'macAddress': '30-0E-D5-14-74-04',
      'hostName': 'Mac Pro 12',
    },
    {
      'ipAddress': '172.16.254.106',
      'macAddress': '24-0H-7N-42-12-65',
      'hostName': 'Mac Pro 12',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final ScanningController scanningController = Get.find(tag: 'scanning');

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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
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
              scanningController.isLoading(true);
              Timer(const Duration(seconds: 1), () {
                scanningController.isLoading(false);
              });
            },
            icon: Icon(
              Icons.repeat,
              color: Color(0xff4A5967),
              size: 16.sp,
              // #5B5B5B
            ),
          ),
        ],
      ),
      body: Obx(() => scanningController.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var scanning in scanningList)
                  Container(
                    height: 200.h,
                    padding: EdgeInsets.all(18.sp),
                    decoration: BoxDecoration(
                      color: Color(0xff181818),
                      borderRadius: BorderRadius.circular(8.sp),
                      // border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                scanning['ipAddress'],
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                'Ip Address',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                scanning['macAddress'],
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                'MAC adress',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff999999),
                                  ),
                                ),
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
                                child: Text(
                                  'Host name: Mac Pro 12',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      )
    );
  }

}