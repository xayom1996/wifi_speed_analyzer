import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget{
  final GestureTapCallback action;
  final String title;
  final String description;

  const CustomDialog({Key key, this.action, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        description,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            "No",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: Text(
            "Yes",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () {
            action();
            Get.back();
          },
        ),
      ],
    );
    return Center(
      child: Container(
        height: 200.h,
        width: 300.w,
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.sp),
          color: Color(0xff1E1E1E).withOpacity(0.9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Delete result',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              'Are you sure you want to delete  this result?',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  child: Text('Yes'),
                    onPressed: () {
                      action();
                      Get.back();
                    }
                ),
                RaisedButton(
                    child: Text('No'),
                    onPressed: () {
                      Get.back();
                    }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}