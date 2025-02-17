import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/utils/app_images.dart';
import 'package:social_media_app/utils/app_styles.dart';

class PostHeaderInfo extends StatelessWidget {
  const PostHeaderInfo({
    super.key,
    required this.profileTapProvider,
    required this.newPostProvider,
  });

  final ProfileTapProvider profileTapProvider;
  final NewPostProvider newPostProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Provider.of<ProfileTapProvider>(context).imageUrl == ''
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: ClipOval(
                      child: Image.asset(Assets.imagesProfileAvatar),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: Provider.of<ProfileTapProvider>(context)
                        .imageUrl,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                      height: 35,
                      width: 35,
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
        DropdownButton<String>(
          dropdownColor: Colors.black,
          isDense: true,
          underline: Container(),
          value: newPostProvider.currentPostMode,
          onChanged: (String? value) {
            if (value == null) return;
    
            newPostProvider.setCurrentPostMode(
              value,
            );
          },
          items: newPostProvider
              .getVisibilityOptions(context)
              .map<DropdownMenuItem<String>>(
                  (Map<String, dynamic> value) {
            return DropdownMenuItem<String>(
              value: value["value"],
              child: Row(
                children: [
                  value["icon"],
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    value["label"],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
