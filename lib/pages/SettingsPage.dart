import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/settings_controller.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class SettingsRoutes {
  static const String settingsPage = 'settings';
  static const String resultPage = 'result';
}

class SettingsNavigator extends StatelessWidget{
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
        initialRoute: SettingsRoutes.settingsPage,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case SettingsRoutes.settingsPage:
              builder =
                  (BuildContext _) => SettingsPage();
              break;
            case SettingsRoutes.resultPage:
              builder =
                  (BuildContext _) => Container();
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

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find(tag: 'settings');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
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
        padding: EdgeInsets.all(18.sp),
        color: backgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(19.sp),
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.circular(8.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    offset: Offset(0, 10.h),
                    spreadRadius: 1,
                    blurRadius: 5
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Share',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16.sp,
                      // color: mainColor,
                      // #5B5B5B
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.all(19.sp),
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.circular(8.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    offset: Offset(0, 10.h),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy Policy',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16.sp,
                      // color: mainColor,
                      // #5B5B5B
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.all(19.sp),
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.circular(8.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    offset: Offset(0, 10.h),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Term of Use',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16.sp,
                      // color: mainColor,
                      // #5B5B5B
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.all(19.sp),
              decoration: BoxDecoration(
                color: Color(0xff181818),
                borderRadius: BorderRadius.circular(8.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    offset: Offset(0, 10.h),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Support',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16.sp,
                      // color: mainColor,
                      // #5B5B5B
                    ),
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