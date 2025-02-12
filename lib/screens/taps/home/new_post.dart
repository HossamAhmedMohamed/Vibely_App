import 'package:flutter/material.dart';
import 'package:social_media_app/utils/app_styles.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: AppStyle.styleRegular25(context).copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
