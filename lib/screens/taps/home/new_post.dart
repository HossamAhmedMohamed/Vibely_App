// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/utils/app_images.dart';
import 'package:social_media_app/utils/app_styles.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  static const List<String> list = <String>['Public', 'Friends', 'Only me'];
  @override
  Widget build(BuildContext context) {
    final profileTapProvider =
        Provider.of<ProfileTapProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: AppStyle.styleRegular25(context).copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {},
              child: Text(
                'Post',
                style: AppStyle.styleRegular20(context)
                    .copyWith(color: Colors.blue),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Provider.of<ProfileTapProvider>(context).imageUrl == ''
                          ? SizedBox(
                              height: 80,
                              width: 80,
                              child: ClipOval(
                                child: Image.asset(Assets.imagesProfileAvatar),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: Provider.of<ProfileTapProvider>(context)
                                  .imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 60,
                                width: 60,
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
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        profileTapProvider.username,
                        style: AppStyle.styleRegular20(context)
                            .copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                  DropdownMenu<String>(
                    inputDecorationTheme:
                        InputDecorationTheme(border: InputBorder.none),
                    initialSelection: list.first,
                    dropdownMenuEntries: list
                        .map((String value) => DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            ))
                        .toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Write something here...',
                    hintStyle: AppStyle.styleRegular20(context)
                        .copyWith(color: Colors.white),
                    border: InputBorder.none),
                minLines: 1,
                maxLines: null,
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 12),
                  decoration: ShapeDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Photo',
                        style: AppStyle.styleRegular20(context)
                            .copyWith(color: Colors.white),
                      ),

                      Icon(Icons.photo)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 12),
                  decoration: ShapeDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Video',
                        style: AppStyle.styleRegular20(context)
                            .copyWith(color: Colors.white),
                      ),

                      Icon(Icons.video_camera_back)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 12),
                  decoration: ShapeDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Location',
                        style: AppStyle.styleRegular20(context)
                            .copyWith(color: Colors.white),
                      ),

                      Icon(Icons.place)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 12),
                  decoration: ShapeDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Occasion',
                        style: AppStyle.styleRegular20(context)
                            .copyWith(color: Colors.white),
                      ),

                      Icon(Icons.announcement)
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
