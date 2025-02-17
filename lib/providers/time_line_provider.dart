// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:social_media_app/controllers/posts_controller.dart';

class TimeLineProvider with ChangeNotifier{
  

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> get posts => _posts;

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> getPosts() async {
    try {
      var res = await PostsController.getAllPosts();

      _posts = res;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getData() async {
    toggleLoading();

    try {
      await getPosts();
    } catch (e) {
      print(e.toString());
    }

    toggleLoading();
  }
}