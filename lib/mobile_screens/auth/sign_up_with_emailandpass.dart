// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pursue/common_widgets/apptoast.dart';
import 'package:pursue/common_widgets/common_logo.dart';
import 'package:pursue/common_widgets/rounded_btn.dart';
import 'package:pursue/mobile_screens/chat/chat_screen1.dart';
import 'package:pursue/mobile_screens/auth/sign_in_with_email_and_pass.dart';
import 'package:http/http.dart' as http;

class SignUpButton extends StatefulWidget {
  final String title;
  final Function onTap;

  const SignUpButton({super.key, required this.title, required this.onTap});

  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      title: widget.title,
      onTap: () async {
        widget.onTap();
      },
    );
  }
}

class SignUpWithEmailPass extends StatefulWidget {
  @override
  State<SignUpWithEmailPass> createState() => _SignUpWithEmailPassState();
}

class _SignUpWithEmailPassState extends State<SignUpWithEmailPass> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEFF3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              const CommonLogo(
                logoWidth: 90,
                logoHeight: 70,
              ),
              const SizedBox(height: 20),
              Text(
                "Sign up",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          label: Text("Name"),
                          hintText: "Enter Your Name",
                          hintStyle: TextStyle(color: Color(0xFF9FAFBC)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2F80ED)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          label: Text("Email"),
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(color: Color(0xFF9FAFBC)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2F80ED)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          label: Text("Password"),
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(color: Color(0xFF9FAFBC)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2F80ED)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPassController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          label: Text("Confirm Password"),
                          hintText: "Confirm Your Password",
                          hintStyle: TextStyle(color: Color(0xFF9FAFBC)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2F80ED)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(height: 10),
                    SignUpButton(
                      title: "Continue",
                      onTap: () async {
                        if (_validateInputs()) {
                          await signUpWithEmailAndPassword();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Already have an Account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const SignInWithEmailPass());
                          },
                        text: 'Login ',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 3,
                          fontSize: 18,
                          color: Color(0xFF2F80ED),
                          fontWeight: FontWeight.bold,
                        ),
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

  bool _validateInputs() {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passController.text.trim().isEmpty ||
        confirmPassController.text.trim().isEmpty) {
      AppToast().toastMessage("All fields are required");
      return false;
    } else if (passController.text.trim() !=
        confirmPassController.text.trim()) {
      AppToast().toastMessage("Passwords do not match");
      return false;
    }
    return true;
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      await userCredential.user?.sendEmailVerification();
      var id = DateTime.now().millisecondsSinceEpoch.toString();
      await createUser(
          id, nameController.text.toString(), emailController.text.toString());

      Get.to(() => ChatScreen1());
      AppToast().toastMessage('Successfully Created Account!');

      final User? user = userCredential.user;
      if (user != null) {
        debugPrint('User signed in: ${user.email}');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error creating user: ${e.message}');
      }
    } catch (e) {
      AppToast().toastMessage(e.toString());
      debugPrint('Failed to sign in: $e');
    }
  }

  Future<void> createUser(String id, String name, String email) async {
    try {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      print(uid);
      String apiUrl = 'https://pursueit.in:8080/user/addUser';

      Map<String, dynamic> userData = {
        'UserID': id,
        'OrderID': "__",
        'CustomerID': "CID$id",
        'Name': name,
        'Email': email,
        'PhoneNumber': 0,
        'DidStartChatbot': false,
        'IsPaidUser': false,
        'Options': [],
        'FinalCareerOptions': [],
      };

      String requestBody = jsonEncode(userData);

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('User created successfully');
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .set(userData);
      } else {
        print('Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error creating user: $error');
    }
  }
}
