import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_speed_analyzer/controllers/scanning_controller.dart';
import 'package:wifi_speed_analyzer/controllers/test_controller.dart';
import 'package:wifi_speed_analyzer/pages/TestResultPage.dart';
import 'package:wifi_speed_analyzer/pages/components/speed_indicator.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class ScanningRoutes {
  static const String ScanningPage = 'history';
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
        child: Center(
          child: Obx(() => scanningController.isLoading.value
              ? CircularProgressIndicator()
              : InkWell(
                onTap: (){
                  scanningController.isLoading(true);
                },
                child: SvgPicture.asset(
                  'assets/icons/иконка.svg',
                  height: 0.4.sh,
                ),
              ),
          )
        ),
      ),
    );
  }

}

class ScanningResultPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}