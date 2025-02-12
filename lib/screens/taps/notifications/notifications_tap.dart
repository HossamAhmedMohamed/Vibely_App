import 'package:flutter/material.dart';

class NotificationsTap extends StatelessWidget {
  const NotificationsTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notifications'),
      ),
    );
  }
}