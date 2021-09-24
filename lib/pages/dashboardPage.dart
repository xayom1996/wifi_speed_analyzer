import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wifi_speed_analyzer/controllers/dashboard_controller.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DashboardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController = Get.find(tag: 'dashboard');

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Obx(() =>
              IndexedStack(
                key: PageStorageKey('Indexed'),
                index: dashboardController.tabIndex.value,
                children: dashboardController.pages,
              ),
          )
      ),
      // bottomNavigationBar: Obx(() => BottomNavigationBar(
      //     currentIndex: dashboardController.tabIndex.value,
      //     selectedItemColor: mainColor,
      //     unselectedItemColor: mainColor1,
      //     showSelectedLabels: true,
      //     showUnselectedLabels: true,
      //     iconSize: 18.sp,
      //     selectedFontSize: 10.sp,
      //     unselectedFontSize: 10.sp,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: FaIcon(FontAwesomeIcons.wifi),
      //         label: 'Test',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: FaIcon(FontAwesomeIcons.history),
      //         label: 'History',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: FaIcon(FontAwesomeIcons.qrcode),
      //         label: 'Scannig',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: FaIcon(FontAwesomeIcons.cog),
      //         label: 'Settings',
      //       ),
      //     ],
      //     onTap: (index) => dashboardController.changeTabIndex(index),
      //   )
      // )
      bottomNavigationBar: MyNavBar(
          items: [
            {
              'iconPath': 'assets/icons/wifi.svg',
              'title': 'Test',
            },
            {
              'iconPath': 'assets/icons/history.svg',
              'title': 'History',
            },
            {
              'iconPath': 'assets/icons/scanning.svg',
              'title': 'Scanning',
            },
            {
              'iconPath': 'assets/icons/settings.svg',
              'title': 'Settings',
            },
          ],
          // icons: [
          //   FaIcon(FontAwesomeIcons.wifi),
          //   FaIcon(FontAwesomeIcons.history),
          //   FaIcon(FontAwesomeIcons.qrcode),
          //   FaIcon(FontAwesomeIcons.cog),
          // ]
      ),
    );
  }
}

class MyNavBar extends StatelessWidget{
  final List<Map> items;
  MyNavBar({Key key, this.items}) : super(key: key);

  final DashboardController dashboardController = Get.find(tag: 'dashboard');

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: bottomNavColor.withOpacity(0.94),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              spreadRadius: 5,
              // blurRadius: 20,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: 25.sp,
          right: 25.sp
        ),
        child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) =>
                InkWell(
                  onTap: (){
                    dashboardController.changeTabIndex(index);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        items[index]['iconPath'],
                          color: dashboardController.tabIndex.value == index
                              ? mainColor
                              : mainColor1,
                          width: 16.sp,
                          height: 22.sp,
                      ),
                      // FaIcon(
                      //   items[index]['faicon'],
                      //   color: dashboardController.tabIndex.value == index
                      //       ? mainColor
                      //       : mainColor1,
                      //   size: 16.sp,
                      // ),
                      // IconButton(
                      //   padding: EdgeInsets.all(0),
                      //   color: dashboardController.tabIndex.value == index
                      //       ? mainColor
                      //       : mainColor1,
                      //   splashColor: Colors.transparent,
                      //   highlightColor: Colors.transparent,
                      //   hoverColor: Colors.transparent,
                      //   iconSize: 20,
                      //   onPressed: () {
                      //     dashboardController.changeTabIndex(index);
                      //   },
                      //   icon: items[index]['icon'],
                      // ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        items[index]['title'],
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: dashboardController.tabIndex.value == index
                              ? mainColor
                              : mainColor1,
                        ),
                      )
                    ],
                  ),
                ),
            ),
          )
        )
    );
  }

}

ListTile buildListTile(
    BuildContext context, IconData icon, String title, Widget onPress) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    onTap: () {
      if(icon == Icons.supervised_user_circle_rounded)
        Navigator.pop(context);
      // Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => onPress));
    },
    leading: Icon(
      icon,
      size: 22,
      color: Theme.of(context).primaryColor,
    ),
    title: Text(
      title,
      style: TextStyle(letterSpacing: 2).copyWith(fontSize: 16),
    ),
  );
}
