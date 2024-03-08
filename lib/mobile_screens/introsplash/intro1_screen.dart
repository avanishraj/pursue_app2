// ignore_for_file: prefer_constructors_over_static_methods, prefer_const_constructors
// ignore_for_file: prefer__ructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pursue/common_widgets/common_logo.dart';
import 'package:pursue/common_widgets/rounded_btn.dart';
import 'package:pursue/mobile_screens/introsplash/intro2_screen.dart';
import 'package:pursue/mobile_screens/auth/login_screen.dart';
import 'package:pursue/screen_controller/mixpanelEvent.dart';

class Intro1Screen extends StatelessWidget {
  Intro1Screen({super.key});
  MixpanelService mixpanelService = MixpanelService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 80,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CommonLogo(
                    logoWidth: 64,
                    logoHeight: 53,
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    "assets/images/screen_2_person.svg",
                    width: 280,
                    height: 210,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
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
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Find Your Dream Career",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        "Welcome to the world of possibilities!\n Discover your true calling and find the career path that lights up your future.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF9FAFBC)),
                      ),
                      SizedBox(height: 35),
                      RoundedButton(
                        title: "Next",
                        onTap: () {
                              mixpanelService.sendEventToMixpanel("Intro1_NextClicked", "Getting into next intro screen");
                          // Use Get.to(() => Intro2Screen()) to navigate with default transition
                          Get.to(() => Intro2Screen(),
                              transition: Transition.rightToLeft);
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                                  mixpanelService.sendEventToMixpanel("Intro1_SkipClicked", "routing to login screen");
                              Get.to(() => LoginScreen());
                            },
                            child: Text(
                              "Skip",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff2F80ED),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                            color: Color.fromARGB(255, 42, 43, 44),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
