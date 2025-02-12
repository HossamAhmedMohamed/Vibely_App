// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/utils/app_images.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:social_media_app/utils/pages_name.dart';
import 'package:social_media_app/widgets/change_profile_photo.dart';
import 'package:social_media_app/widgets/log_out_dialog.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  // void initState() {
  //   Provider.of<ProfileTapProvider>(context , listen: false).getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final profileProvider = Provider.of<ProfileTapProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await changePhotoDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Provider.of<ProfileTapProvider>(context).imageUrl == ''
                          ? SizedBox(
                              height: 150,
                              width: 150,
                              child: ClipOval(
                                child: Image.asset(Assets.imagesProfileAvatar),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: Provider.of<ProfileTapProvider>(context)
                                  .imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    60,
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Provider.of<ProfileTapProvider>(context).username,
                  style: AppStyle.styleSemiBold20(context).copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Provider.of<ProfileTapProvider>(context).email,
                  style: AppStyle.styleSemiBold20(context).copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Provider.of<ProfileTapProvider>(context).phone,
                  style: AppStyle.styleSemiBold20(context).copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.white,
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account Settings',
                          style: AppStyle.styleSemiBold20(context).copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    // Provider.of<AppSettingsProvider>(context, listen: false)
                    //     .setIsDark(Globals.theme == "Dark" ? false : true);
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed(appSettingsScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'App Settings',
                          style: AppStyle.styleSemiBold20(context).copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Preferences',
                          style: AppStyle.styleSemiBold20(context).copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacy',
                          style: AppStyle.styleSemiBold20(context).copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.white,
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showLogOutDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                        color: Colors.red.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Log Out',
                          style: AppStyle.styleSemiBold20(context).copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
