import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:wifi_speed_analyzer/controllers/test_controller.dart';
import 'package:wifi_speed_analyzer/pages/TestPage.dart';
import 'package:wifi_speed_analyzer/pages/TestResultPage.dart';
import 'package:wifi_speed_analyzer/pages/components/draw_points.dart';
import 'package:wifi_speed_analyzer/pages/components/speedometer.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class SpeedIndicator extends StatefulWidget {
  @override
  _SpeedIndicatorState createState() => _SpeedIndicatorState();
}

class _SpeedIndicatorState extends State<SpeedIndicator> {
  final TestController testController = Get.find(tag: 'test');

  final internetSpeedTest = InternetSpeedTest();
  final RxDouble speed = 0.0.obs;
  final RxString status = 'download'.obs;

  RxList<Offset> downloadSpeedPoints = <Offset>[].obs;
  RxList<Offset> uploadSpeedPoints = <Offset>[].obs;

  void startDownloadTesting(){
    internetSpeedTest.startDownloadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        testController.downloadSpeed(transferRate);
        status('upload');
        speed(0.0);
        startUploadTesting();
        // TODO: Change UI
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        print(
            'the transfer rate $transferRate, the percent $percent');
        speed(transferRate);
        downloadSpeedPoints.add(Offset(percent, transferRate));
        // TODO: Change UI
      },
      onError: (String errorMessage, String speedTestError) {
        // TODO: Show toast error
      },
      // testServer: 'https://www.google.com/'
    );
  }

  void startUploadTesting(){
    internetSpeedTest.startUploadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        print('the transfer rate $transferRate');
        testController.uploadSpeed(transferRate);
        speed(0.0);
        testController.isPressed(false);
        status('');
        uploadSpeedPoints([]);
        downloadSpeedPoints([]);
        // Get.to(() => TestResultPage());
        Navigator.pushNamed(context, TestRoutes.ResultPage);
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        print('the transfer rate $transferRate, the percent $percent');
        speed(transferRate);
        uploadSpeedPoints.add(Offset(percent, transferRate));
      },
      onError: (String errorMessage, String speedTestError) {
        // TODO: Show toast error
      },
      // testServer: 'https://www.google.com/'
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    startDownloadTesting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Obx(() => AnimatedSwitcher(
            duration: Duration(milliseconds: 3000),
                child: Speedometer(
                  speed: speed.value,
                  size: 300.w,
                  // speedRecord: highestVelocity,
                ),
            ),
          ),
        ),
        Obx(() => Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                      color: status.value == 'download'
                          ? mainColor
                          : mainColor1,
                      size: 16.sp,
                        // #5B5B5B
                    ),
                  ],
                ),
                Container(
                  height: 100.h,
                  // width: 100,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: status.value == 'download'
                    ? CustomPaint(
                        size: Size(100.w, 150.h),
                        painter: MyPainter(
                            points: downloadSpeedPoints
                        )
                    )
                    : Row(
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
                    ),
                  ),
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
                      color: status.value == 'upload'
                          ? mainColor
                          : mainColor1,
                      size: 16.sp,
                    ),
                  ],
                ),
                Container(
                  height: 100.h,
                  // width: 100,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: status.value == 'upload'
                    ? CustomPaint(
                        size: Size(100.w, 150.h),
                        painter: MyPainter(
                            points: uploadSpeedPoints
                        )
                    )
                    : Row(
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
                    ),
                  ),
                )
              ],
            ),
          ],
        ))
      ],
    );
  }
}