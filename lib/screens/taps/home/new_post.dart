// ignore_for_file: deprecated_member_use, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/location_viewer_provider.dart';
import 'package:social_media_app/screens/taps/home/full_screen_photo.dart';
import 'package:social_media_app/utils/pages_name.dart';
import 'package:social_media_app/widgets/location_dialog.dart';
import 'package:social_media_app/widgets/post_photo_dialog.dart';
import 'package:social_media_app/widgets/posts_header.dart';
import 'package:social_media_app/widgets/show_cauroslie_slider.dart';
import 'package:social_media_app/widgets/show_occasion_dialog.dart';
import 'package:video_player/video_player.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late NewPostProvider newPostProviderClearing;

  @override
  void initState() {
    super.initState();
    newPostProviderClearing =
        Provider.of<NewPostProvider>(context, listen: false);
  }

  @override
  void dispose() {
    newPostProviderClearing.textController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileTapProvider =
        Provider.of<ProfileTapProvider>(context, listen: false);

    final newPostProvider = Provider.of<NewPostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: AppStyle.styleRegular25(context).copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              newPostProvider.locationData.clear();
              newPostProvider.media.clear();
              newPostProvider.setIsOcassionSelected(false);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                newPostProvider.addPost(context);
              },
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
              PostHeaderInfo(
                  profileTapProvider: profileTapProvider,
                  newPostProvider: newPostProvider),
              Row(
                children: [
                  newPostProvider.isOccasionSelected
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                              onPressed: () {
                                showOccasionEditingDialog(
                                    context, newPostProvider);
                              },
                              label: Text(
                                newPostProvider
                                    .getOccasionsOptions(context)
                                    .firstWhere((element) =>
                                        element["value"] ==
                                        newPostProvider
                                            .selectedOccasion)["label"]
                                    .toString(),
                              ),
                              icon: newPostProvider
                                  .getOccasionsOptions(context)
                                  .firstWhere((element) =>
                                      element["value"] ==
                                      newPostProvider.selectedOccasion)["icon"],
                            ),
                          ],
                        )
                      : Container(),
                  newPostProvider.locationData.isEmpty
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                              onPressed: () {
                                showLocationDialog(context, newPostProvider);
                              },
                              label: Text('Location'),
                              icon: const Icon(Icons.location_pin),
                            ),
                          ],
                        ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: newPostProvider.textController,
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
              newPostProvider.media.isEmpty
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: newPostProvider.media.length == 1
                          ? newPostProvider.media[0]["type"] == "photo"
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenPhoto(
                                                        imgUrl: newPostProvider
                                                            .media[0]["url"]
                                                            .toString(),
                                                      )));
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: newPostProvider.media[0]
                                                  ["url"]
                                              .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                            child: Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        child: InkWell(
                                            onTap: () {
                                              newPostProvider
                                                  .removeMediaAtIndex(
                                                      newPostProvider.media
                                                          .indexOf(
                                                              newPostProvider
                                                                  .media[0]));
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : FlickVideoPlayer(
                                  flickManager: FlickManager(
                                    videoPlayerController:
                                        VideoPlayerController.networkUrl(
                                      Uri.parse(
                                        newPostProvider.media[0]["url"]
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                )
                          : PhotosAndVideosCarouselSlider(
                              newPostProvider: newPostProvider,
                            ),
                    ),
              InkWell(
                onTap: () {
                  showPostPhotoDialog(context, newPostProvider);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                onTap: () {
                  showVideoPostDialog(context, newPostProvider);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                onTap: () async {
                  await Navigator.pushNamed(context, locationScreen);

                  final locationViewerProvider =
                      Provider.of<LocationViewerProvider>(context,
                          listen: false);

                  if (locationViewerProvider.currentLocation.latitude != 0 &&
                      locationViewerProvider.currentLocation.longitude != 0) {
                    newPostProvider.setLocationData(
                      locationViewerProvider.currentLocation.toMap(),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                onTap: () {
                  showOccasionDialog(context, newPostProvider);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
