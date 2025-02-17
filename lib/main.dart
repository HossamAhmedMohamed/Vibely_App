// ignore_for_file: avoid_print

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/providers/app_settings_provider.dart';
import 'package:social_media_app/providers/home_screen_provider.dart';
import 'package:social_media_app/providers/location_viewer_provider.dart';
import 'package:social_media_app/providers/login_provider.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/providers/sign_up_provider.dart';
import 'package:social_media_app/providers/time_line_provider.dart';
import 'package:social_media_app/routing.dart';
import 'package:social_media_app/utils/pages_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print(e.toString());
  }
  try {
    await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"].toString(),
      anonKey: dotenv.env["SUPABASE_KEY"].toString(),
    );
  } catch (e) {
    print(e.toString());
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e.toString());
  }

  // try {
  //   final savedThemeMode = await AdaptiveTheme.getThemeMode();
  //   if (savedThemeMode != null) {
  //     if (savedThemeMode == AdaptiveThemeMode.light) {
  //       Globals.theme = "Light";
  //     }
  //     else {
  //       Globals.theme = "Dark";
  //     }
  //   }
  // } catch (e) {
  //   print(e.toString());
  // }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
      ),
      ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
      ChangeNotifierProvider(create: (_) => ProfileTapProvider()),
      ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
      ChangeNotifierProvider(create: (_)=> NewPostProvider()),
      ChangeNotifierProvider(create: (_)=> LocationViewerProvider()),
      ChangeNotifierProvider(create: (_)=> TimeLineProvider())
    ],
    child: MyApp(
      appRouter: AppRouter(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Merhaba',
    //   theme: ThemeData.dark(),
    //   home:  WelcomeScreen()
    // );

    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => FluentApp(
        title: 'Merhaba',
        debugShowCheckedModeBanner: false,
        theme:
        //  theme == ThemeData.light(useMaterial3: true)
        //     ? FluentThemeData.light()
        //     : 
            FluentThemeData.dark(),
        // darkTheme: darkTheme == ThemeData.dark(useMaterial3: true)
        //     ? FluentThemeData.dark()
        //     : FluentThemeData.light(),
        initialRoute: welcomeScreen,
        onGenerateRoute: appRouter.generationRoute,
        // home:  WelcomeScreen(),
      ),
    );
  }
}
