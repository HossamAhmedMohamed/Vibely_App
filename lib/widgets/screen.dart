import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/log_out_dialog.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              showLogOutDialog(context);
            },
            child: Text('log_out')),
      ),
    );
  }
}
