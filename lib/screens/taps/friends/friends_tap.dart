import 'package:flutter/material.dart';

class FriendsTap extends StatelessWidget {
  const FriendsTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Friends'),
      ),
    );
  }
}