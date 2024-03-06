// ignore_for_file: prefer_constructors_over_static_methods, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pursue/common_widgets/common_logo.dart';
import 'package:pursue/common_widgets/rounded_btn.dart';
import 'package:pursue/mobile_screens/auth/login_screen.dart';

class Intro2Screen extends StatelessWidget {
  const Intro2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonLogo(
                  logoWidth: 64,
                  logoHeight: 53,
                ),
                SizedBox(height: 30),
                SvgPicture.asset(
                  "assets/images/screen_3_person.svg",
                  width: 280,
                  height: 210,
                ),
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      // scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 40, top: 20),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 15),
                                        buildIconContent(
                                          iconPath: "assets/icons/icon_1.svg",
                                          text: "Answer a few Questions",
                                          iconSize:
                                              24, // Adjust the size of the icon
                                          textSize:
                                              15, // Adjust the size of the text
                                        ),
                                        SizedBox(height: 15),
                                        buildIconContent(
                                          iconPath: "assets/icons/icon_4.svg",
                                          text:
                                              "Get careers suggested just for you",
                                          iconSize:
                                              24, // Adjust the size of the icon
                                          textSize:
                                              15, // Adjust the size of the text
                                        ),
                                        SizedBox(height: 15),
                                        buildIconContent(
                                          iconPath: "assets/icons/icon_3.svg",
                                          text: "Access top courses",
                                          iconSize:
                                              24, // Adjust the size of the icon
                                          textSize:
                                              15, // Adjust the size of the text
                                        ),
                                        SizedBox(height: 15),
                                        buildIconContent(
                                          iconPath: "assets/icons/icon_2.svg",
                                          text:
                                              "Pursue your chosen career path",
                                          iconSize:
                                              24, // Adjust the size of the icon
                                          textSize:
                                              15, // Adjust the size of the text
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      height: 50,
                                      width: 400,
                                      child: RoundedButton(
                                          title: "Get Started",
                                          onTap: () {
                                            Get.to(() => LoginScreen(),
                                                transition:
                                                    Transition.rightToLeft);
                                          }),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 45),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 3,
                                      color: Color(0xff2F80ED),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 40,
                                      height: 3,
                                      color: Color(0xff2F80ED),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIconContent({
    required String iconPath,
    required String text,
    double iconSize = 22,
    double textSize = 18,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          height: iconSize,
          width: iconSize,
        ),
        SizedBox(width: 10), // Adjust spacing between icon and text
        Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
