import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'speedometer.dart';

class SpeedometerContainer extends StatefulWidget {
  @override
  _SpeedometerContainerState createState() => _SpeedometerContainerState();
}

class _SpeedometerContainerState extends State<SpeedometerContainer> {
  RxDouble speed = 20.0.obs;
  RxDouble downloadSpeed = 0.0.obs;
  RxDouble uploadSpeed = 0.0.obs;

  final internetSpeedTest = InternetSpeedTest();

  void startDownloadTesting(){
    internetSpeedTest.startDownloadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        downloadSpeed(transferRate);
        // TODO: Change UI
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        print(
            'the transfer rate $transferRate, the percent $percent');
        speed(transferRate);
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
        uploadSpeed(transferRate);
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        print(
            'the transfer rate $transferRate, the percent $percent');
        speed(transferRate);
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
    return Container(
      child: Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 3000),
        child: Speedometer(
          speed: speed.value,
          // speedRecord: highestVelocity,
        ),
      )),
    );
  }
}