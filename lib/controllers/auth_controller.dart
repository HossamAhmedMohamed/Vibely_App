// ignore_for_file: avoid_print

import 'package:social_media_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  static Future<void> setAuth(Map<String, dynamic> data) async {
    try {
      await flutterSecureStorage.write(
        key: "is_logged_in",
        value: true.toString(),
      );
      await flutterSecureStorage.write(
        key: "login_email",
        value: data["email"].toString(),
      );
      await flutterSecureStorage.write(
        key: "login_password",
        value: data["password"].toString(),
      );
      await flutterSecureStorage.write(
        key: "uid",
        value: data["uid"].toString(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> purgeAuth() async {
    try {
      await flutterSecureStorage.delete(key: "is_logged_in");
      await flutterSecureStorage.delete(key: "login_email");
      await flutterSecureStorage.delete(key: "login_password");
      await flutterSecureStorage.delete(key: "uid");
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Map<String, dynamic>> createAccount(
      Map<String, dynamic> data) async {
    try {
      var res = await Supabase.instance.client.auth.signUp(
          password: data['password'].toString(),
          email: data['email'].toString(),
          data: {
            ...data,
          });

      if (res.user == null) {
        return {
          "result": false,
          "message": "Failed to create account",
        };
      }

      return {
        "result": true,
        "message": "Account created successfully",
        "data": {...res.user!.toJson()}
      };
    } on AuthException catch (e) {
      print(e.message.toString());
      return {
        "result": false,
        "message": e.message,
      };
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      var res = await Supabase.instance.client.auth.signInWithPassword(
        password: password,
        email: email.toLowerCase().trim(),
      );

      if (res.user == null) {
        return {
          "result": false,
          "message": "Failed to login",
        };
      }

      await setAuth({
        "email": email.toLowerCase().trim(),
        "password": password,
        "uid": res.user!.id,
      });

      return {
        "result": true,
        "message": "Logged in successfully",
        "data": {...res.user!.toJson()}
      };
    } on AuthException catch (e) {
      print(e.message.toString());
      return {
        "result": false,
        "message": e.message,
      };
    }
  }

   static Future<void> logOut() async {
    try {
      try {
        await Supabase.instance.client.auth.signOut();
      } catch (e) {
        print(e.toString());
      }

      try {
        await purgeAuth();
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }


  static Future<Map<String, dynamic>> getCurrentUserData() async {
    try {
      var uid = await flutterSecureStorage.read(
        key: "uid",
      );

      if (uid == null) {
        return {
          "result": false,
          "message": "Please login again!!",
        };
      }

      var res = Supabase.instance.client.auth.currentUser!.toJson();

      return {
        "result": true,
        "message": "Retrieved successfully .. ",
        "data": res,
      };
    } catch (e) {
      return {
        "result": false,
        "message": e.toString(),
      };
    }
  }

   static Future<Map<String, dynamic>> updateCurrentUserData(
      Map<String, dynamic> data) async {
    try {
      await Supabase.instance.client.auth.updateUser(UserAttributes(data: {
        ...data,
      }));

      return {
        "result": true,
        "message": "Updated successfully ... ",
      };
    } catch (e) {
      print(e.toString());
      return {
        "result": false,
        "message": e.toString(),
      };
    }
  }
}
