import 'dart:convert';
import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:wifi_speed_analyzer/models/wifi_speed.dart';
import 'package:http/http.dart' as http;

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
    var ipAddress = await Ipify.ipv4();
    var device = '';
    var server = '';
    var isp = '';

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

    try{
      var wifiInfo = await getWifiInfo(ipAddress);
      print(wifiInfo);
      server = "${wifiInfo['country']}, ${wifiInfo['countryCode']}";
      isp = wifiInfo['isp'];
    }catch(e){
      print(e);
    }

    WifiSpeed wifiSpeed = WifiSpeed(
      downloadSpeed: downloadSpeed,
      uploadSpeed: uploadSpeed,
      name: wifiName,
      ipAddress: ipAddress,
      device: device,
      server: server,
      isp: isp,
    );
    wifiSpeed = await wifiSpeedProvider.insert(wifiSpeed);
    wifiSpeeds.add(wifiSpeed);
  }

  void deleteAll() async{
    try {
      await wifiSpeedProvider.deleteAll();
      wifiSpeeds([]);
    }catch(e){

    }
  }

  Future<dynamic> getWifiInfo(String ipAddress) async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/$ipAddress'));

    if (response.statusCode != 200) {
      throw Exception('error');
    }

    final objJson = jsonDecode(response.body);
    return objJson;
  }
}