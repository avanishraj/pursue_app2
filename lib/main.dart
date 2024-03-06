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
  runApp(MyApp(
    hyperSDK: hyperSDK,
  ));
}

class MyApp extends StatefulWidget {
  final HyperSDK hyperSDK;
  const MyApp({Key? key, required this.hyperSDK}) : super(key: key);

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
      home: SplashScreenWithTransition(
        hyperSDK: widget.hyperSDK,
      ),
    );
  }
}

class SplashScreenWithTransition extends StatelessWidget {
  final HyperSDK hyperSDK;

  const SplashScreenWithTransition({Key? key, required this.hyperSDK})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: SplashScreen(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
