import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/pages/OnBoardingPage.dart';
import 'package:wifi_speed_analyzer/pages/dashboardPage.dart';
import 'package:wifi_speed_analyzer/theme/app_theme.dart';
import 'package:wifi_speed_analyzer/controllers/dashboard_bindings.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appThemeData[AppTheme.RedDark],
        title: "Wifi",
        initialBinding: DashboardBinding(),
        home: OnBoardingPage(),
      ),
    );
  }
}