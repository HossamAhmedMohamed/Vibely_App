import 'package:flutter/material.dart';

class VideosTap extends StatelessWidget {
  const VideosTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Videos'),
      ),
    );
  }
}