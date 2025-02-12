// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:social_media_app/controllers/auth_controller.dart';

class ProfileTapProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _imgUrl = "";
  String get imageUrl => _imgUrl;

  String _email = "";
  String get email => _email;

  String _username = "";
  String get username => _username;

  String _phone = "";
  String get phone => _phone;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // void setImageUrl(String url) {
  //   _imgUrl = url;
  // }

  Future<void> getUserData() async {
    try {
      var res = await AuthController.getCurrentUserData();
      if (res["result"] == true) {
        var userData = res["data"]["user_metadata"];
        _email = userData["email"].toString();
        _username = userData["fullName"].toString();
        _phone = userData["phone"].toString();
        _imgUrl =
            userData["picUrl"] == null ? "" : userData["picUrl"].toString();

        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await getUserData();
    } catch (e) {
      print(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateUserProfilePicture(String url) async {
    toggleLoading();

    try {
      var res = await AuthController.updateCurrentUserData({
        "picUrl": url,
      });

      if (res["result"] == true) {
        _imgUrl = url;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }

    toggleLoading();
  }
}
