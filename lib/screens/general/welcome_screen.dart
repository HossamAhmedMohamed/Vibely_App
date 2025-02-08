// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/utils/app_images.dart';
import 'package:social_media_app/utils/pages_name.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Timer? timer;

  int timerStart = 2;
    final isLoggedIn = flutterSecureStorage.read(
    key: "is_logged_in",
  );
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timerStart == 0) {
        timer.cancel();
        //  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return LoginScreen();
        // }));
        try {
           
          String? loggedIn = await isLoggedIn;
          if (loggedIn == null) {
            Navigator.of(context).pushReplacementNamed(loginScreen);
          } else {
            Navigator.pushReplacementNamed(context, homeScreen);
          }
        } catch (e) {
          print(e.toString());
          Navigator.of(context).pushReplacementNamed(loginScreen);
        }
      } else {
        setState(() {
          timerStart--;
        });
      }
    });
  }

  // Future<void> checkLogin() async {
  //   try {
  //     var res = await AuthController.checkLogin();
  //     if (res["result"] == true) {
  //       Navigator.pushReplacementNamed(context, homeScreen);
  //     } else {
  //       Navigator.of(context).pushReplacementNamed(loginScreen);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Navigator.of(context).pushReplacementNamed(loginScreen);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(Assets.imagesMerhabaLogoDark),
      ),
    );
  }
}
