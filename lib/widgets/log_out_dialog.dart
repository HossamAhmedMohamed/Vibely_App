// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:social_media_app/controllers/auth_controller.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:social_media_app/utils/pages_name.dart';

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 55,
        ),
        child: AlertDialog(
            scrollable: true,
            titlePadding: EdgeInsets.zero,
            backgroundColor: const Color.fromARGB(255, 69, 68, 68),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop();
                    },
                    child: Icon(
                      Icons.close,
                      size: MediaQuery.sizeOf(context).width > 600 ? 40 : null,
                    )),
                const SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Text(
                    "Are you sure you want to log out ?",
                    style: AppStyle.styleSemiBold25(context)
                        .copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        child: Text("No",
                            style: AppStyle.styleBold16(context)
                                .copyWith(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          AuthController.logOut();
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop();
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamedAndRemoveUntil( loginScreen, (routes)=> false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        child: Text("Yes",
                            style: AppStyle.styleBold16(context)
                                .copyWith(color: Colors.black)),
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
    },
  );
}
