// ignore_for_file: prefer_final_fields, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/controllers/posts_controller.dart';

class NewPostProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _currentPostMode = "public";
  String get currentPostMode => _currentPostMode;

  List<Map<String, dynamic>> _media = [];
  List<Map<String, dynamic>> get media => _media;

  Map<String, dynamic> _locationData = {};
  Map<String, dynamic> get locationData => _locationData;

  int _currentPhotoIndex = 0;
  int get currentPhotoIndex => _currentPhotoIndex;

  bool _isOccasionSelected = false;
  bool get isOccasionSelected => _isOccasionSelected;

  String _selectedOccasion = "graduation";
  String get selectedOccasion => _selectedOccasion;

  TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  

  Future<void> addPost(BuildContext context) async {
    if (_textController.text == "") {
      return;
    }

    toggleLoading();

    try {
      var res = await PostsController.addPost(
        {
          "content": jsonEncode({
            "text": _textController.text,
            "media": _media,
            "location": _locationData,
            "occasion": _selectedOccasion,
          }),
        },
      );

      if (res["result"] == true) {
        Fluttertoast.showToast(
          msg: 'Posted Successfully!',
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong!',
        );
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: 'Something went wrong!',
      );
    }

    toggleLoading();
  }

  setSelectedOccasion(String value) {
    toggleLoading();

    try {
      _selectedOccasion = value;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }

    toggleLoading();
  }

  setIsOcassionSelected(bool value) {
    _isOccasionSelected = value;
    notifyListeners();
  }

  setLocationData(Map<String, dynamic> value) {
    _locationData = value;
    notifyListeners();
  }

  removeLocationData() {
    locationData.clear();
    notifyListeners();
  }

  addNewMedia(Map<String, dynamic> data) {
    _media.add(data);
    notifyListeners();
  }

  addNewMedias(List<Map<String, dynamic>> data) {
    _media.addAll(data);
    notifyListeners();
  }
  removeMediaAtIndex(int index) {
    _media.removeAt(index);
    notifyListeners();
  }

  clearMedia() {
    _media.clear();
    notifyListeners();
  }

  setCurrentPhotoIndex(int value) {
    _currentPhotoIndex = value;
    notifyListeners();
  }

  setCurrentPostMode(String value) {
    _currentPostMode = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> getVisibilityOptions(BuildContext context) {
    List<Map<String, dynamic>> list = [
      {
        "label": "public",
        "value": "public",
        "icon": const Icon(
          Icons.group,
        ),
      },
      {
        "label": "friends",
        "value": "friends",
        "icon": const Icon(
          Icons.public,
        ),
      },
      {
        "label": "only me",
        "value": "only_me",
        "icon": const Icon(
          Icons.remove_red_eye,
        ),
      },
    ];

    return list;
  }

  List<Map<String, dynamic>> getOccasionsOptions(BuildContext context) {
    List<Map<String, dynamic>> list = [
      {
        "label": 'graduation',
        "value": "graduation",
        "icon": const Icon(
          Icons.account_balance,
        ),
      },
      {
        "label": 'engagement',
        "value": "engagement",
        "icon": const Icon(
          Icons.circle_outlined,
        ),
      },
      {
        "label": 'marriage',
        "value": "marriage",
        "icon": const Icon(
          Icons.female,
        ),
      },
    ];

    return list;
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
