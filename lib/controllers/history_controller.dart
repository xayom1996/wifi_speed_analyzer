import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:wifi_speed_analyzer/models/wifi_speed.dart';

class HistoryController extends GetxController{
  WifiSpeedProvider wifiSpeedProvider = WifiSpeedProvider();
  final info = NetworkInfo();
  RxList<WifiSpeed> wifiSpeeds = <WifiSpeed>[].obs;

  @override
  void onInit() {
    initDb();
    super.onInit();
  }

  void initDb() async {
    await wifiSpeedProvider.open('wifiSpeed.db');
    wifiSpeeds(await wifiSpeedProvider.getAll());
  }

  void insertWifiSpeed(double downloadSpeed, double uploadSpeed) async {
    var wifiName = await info.getWifiName(); // FooNetwo
    var ipAddress = await info.getWifiIP();
    var device = '';

    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        device = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        device = iosInfo.model;
      }
    } catch(e){
      print(e);
    }
    WifiSpeed wifiSpeed = WifiSpeed(
      downloadSpeed: downloadSpeed,
      uploadSpeed: uploadSpeed,
      name: wifiName,
      ipAddress: ipAddress,
      device: device,
    );
    wifiSpeed = await wifiSpeedProvider.insert(wifiSpeed);
    wifiSpeeds.add(wifiSpeed);
  }
}