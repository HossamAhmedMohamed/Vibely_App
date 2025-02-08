
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  toggleLoading(){
    _isLoading = !_isLoading;
    notifyListeners();
  }
}