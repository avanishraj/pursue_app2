// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pursue/common_widgets/apptoast.dart';
import 'package:pursue/common_widgets/common_logo.dart';
import 'package:pursue/mobile_screens/auth/forget_pass.dart';
import 'package:pursue/mobile_screens/chat/chat_screen1.dart';

class SignInWithEmailPass extends StatefulWidget {
  const SignInWithEmailPass({Key? key}) : super(key: key);

  @override
  State<SignInWithEmailPass> createState() => _SignInWithEmailPassState();
}

class _SignInWithEmailPassState extends State<SignInWithEmailPass> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isLoading = false; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  CommonLogo(
                    logoWidth: 90,
                    logoHeight: 70,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Login ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Enter Your Registered Email",
                              hintStyle: TextStyle(color: Color(0xFF9FAFBC)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF2F80ED)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passController,
                          obscureText: true,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: "Enter Your Password",
                              hintStyle: TextStyle(color: Color(0xFF9FAFBC)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF2F80ED)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    signInWithEmailAndPassword();
                                  },
                                  child: Container(
                                    height: 51,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff2F80ED),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: "Forgotten your password? ",
                          ),
                          TextSpan(
                            text: "Click Here",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => ForgetPassword());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          if (_isLoading) // Show CPI conditionally
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      setState(() {
        _isLoading = true; // Show CPI while signing in
      });

      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      Get.to(() => ChatScreen1());

      // Signed in
      final User? user = userCredential.user;
      if (user != null) {
        debugPrint('User signed in: ${user.email}');
        var email = user.email;
        AppToast().toastMessage("Successfully Logged In using : $email");
        // Navigate to the next screen or perform necessary actions after sign-in
      }
    } catch (e) {
      AppToast().toastMessage(e.toString());

      debugPrint('Failed to sign in: $e');
      // Handle sign-in failure, e.g., show an error message
    } finally {
      setState(() {
        _isLoading = false; // Hide CPI when sign-in process is complete
      });
    }
  }
}
