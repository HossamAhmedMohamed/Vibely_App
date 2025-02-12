// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:social_media_app/screens/authentication/login_screen.dart';
import 'package:social_media_app/screens/authentication/sign_up_screen.dart';
import 'package:social_media_app/screens/general/home_screen.dart';
import 'package:social_media_app/screens/general/welcome_screen.dart';
import 'package:social_media_app/screens/taps/home/new_post.dart';
import 'package:social_media_app/screens/taps/profile/app_settings.dart';
import 'package:social_media_app/utils/pages_name.dart';

class AppRouter {
  Route? generationRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());

      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());

      case homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case appSettingsScreen:
        return MaterialPageRoute(builder: (context) => AppSettings());

      case postScreen:
        return MaterialPageRoute(builder: (context) => NewPost());
    }
  }
}
