import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pursue/mobile_screens/introsplash/splash_screen.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';

final hyperSDK = HyperSDK();
List<List<String>> selectedOptions = [];
void main() async {
  final hyperSDK = HyperSDK();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(hyperSDK: hyperSDK,));
}

class MyApp extends StatefulWidget {
  final HyperSDK hyperSDK;
  const MyApp({super.key, required this.hyperSDK});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pursue',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}