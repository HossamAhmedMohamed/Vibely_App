import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier{
  
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  void toggleVisibility(bool value) {
    _isVisible = value;
    notifyListeners();
  }
}