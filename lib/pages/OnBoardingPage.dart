import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_speed_analyzer/pages/dashboardPage.dart';
import 'package:wifi_speed_analyzer/theme/color_theme.dart';

class OnBoardingPage extends StatelessWidget {
  final _controller = PageController();

  RxInt _currentIndex = 0.obs;

  final explanationPages = [
    ExplanationPage(
      title: 'Choose the best  internet',
      description: 'We let you choose the best network to connect',
      localImages: ['assets/icons/onboarding_icon_1.svg'],
      isLastPage: false,
    ),
    ExplanationPage(
      title: 'Help us to improve the app',
      description: 'We constantly improving the application and it is important for us to know your opinion!',
      localImages: ['assets/icons/feedback_1.svg', 'assets/icons/feedback_2.svg'],
      isLastPage: false,
    ),
    ExplanationPage(
      title: 'Best choice for network testing',
      description: 'Test your network and find out the speed of your Internet quickly and conveniently!',
      localImages: ['assets/icons/onboarding_icon_2.svg'],
      isLastPage: false,
    ),
    ExplanationPage(
      title: 'Test your internet to know its real speed',
      description: 'Subscribe to unlock all the features, just \$3.99/w',
      localImages: ['assets/icons/onboarding_icon_3.svg'],
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Material(
      type: MaterialType.transparency,
      child: Container(
          color: backgroundColor,
          child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: PageView(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        controller: _controller,
                                        onPageChanged: (value) {
                                          _currentIndex(value);
                                        },
                                        children: explanationPages,
                                    )
                                ),
                                flex: 4
                            ),
                            // SizedBox(
                            //   height: 50.h,
                            // ),
                            Obx(() => Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        // margin: const EdgeInsets.symmetric(vertical: 24),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(explanationPages.length,
                                                  (index) => createCircle(index: index)),
                                        )
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(8.sp),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.sp),
                                        ),
                                        padding: EdgeInsets.all(16.sp),
                                        onPressed: (){
                                          _controller.nextPage(
                                              duration: Duration(milliseconds: 200),
                                              curve: Curves.easeInOut
                                          );
                                        },
                                        color: mainColor,
                                        child: Text(
                                          'Next',
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
                                )
                            )),
                            Obx(() => Expanded(
                              flex: 1,
                              child: _currentIndex.value == explanationPages.length - 1
                                  ? Text(
                                      'Privacy Policy | Terms of Use \n Restore purchases',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffBDBDBD),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ))
                          ],
                        ),
                      )
                ]),
              ))
      ),
    );
  }

  createCircle({int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 8.w),
        height: 8.w,
        width: 8.w, // current indicator is wider
        decoration: BoxDecoration(
            color: _currentIndex.value != index ? Color(0xffBDBDBD): mainColor,
            borderRadius: BorderRadius.circular(8.w),
        )
    );
  }
}

class ExplanationPage extends StatelessWidget{
  final String title;
  final String description;
  final List<String> localImages;
  final bool isLastPage;

  const ExplanationPage({Key key, this.title, this.description, this.localImages, this.isLastPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLastPage)
          Positioned(
              top: 8.sp,
              left: 8.sp,
              child: IconButton(
                onPressed: (){
                  return Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                        (route) => false,
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.times,
                  size: 16.sp,
                  // #5B5B5B
                ),
              ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var img in localImages)
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(
                      img,
                      alignment: Alignment.center,
                      height: localImages.length == 1 ? 252.h : 128.h,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffBDBDBD),
                          ),
                        ),
                      ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

