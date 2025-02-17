// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:social_media_app/utils/pages_name.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Text(
            'MERHABA',
            style: AppStyle.styleSemiBold28(context)
                .copyWith(color: Colors.white, fontFamily: 'Inter'),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(duration: 3000.ms, color: const Color(0xFF80DDFF))
              .animate(
                  // onPlay: (controller) => controller.repeat(),
                  ) // this wraps the previous Animate in another Animate
              .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
              .slide()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await Provider.of<ProfileTapProvider>(context, listen: false)
                      .getData();
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(postScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  decoration: ShapeDecoration(
                      color: Colors.blueGrey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "What's on your mind?",
                            style: AppStyle.styleRegular22(context)
                                .copyWith(color: Colors.white),
                          ),
                          Icon(
                            Icons.photo,
                            size: 25,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: 2,
              //   color: const Color(0x8080DDFF),
              //   margin: const EdgeInsets.symmetric(vertical: 5),
              // ).animate().scale(
              //       duration: 1200.ms,
              //       alignment: Alignment.centerLeft,
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}
