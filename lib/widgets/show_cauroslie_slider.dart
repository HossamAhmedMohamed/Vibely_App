// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/screens/taps/home/full_screen_photo.dart';
import 'package:video_player/video_player.dart';

class PhotosAndVideosCarouselSlider extends StatelessWidget {
  PhotosAndVideosCarouselSlider({super.key, required this.newPostProvider});

  final NewPostProvider newPostProvider;
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: newPostProvider.media
              .map(
                (item) => item["type"] == "photo"
                    ? Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreenPhoto(
                                            imgUrl: item["url"].toString(),
                                          )));
                            },
                            child: CachedNetworkImage(
                              imageUrl: item["url"].toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
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
                                  newPostProvider.removeMediaAtIndex(
                                      newPostProvider.media.indexOf(item));
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                )),
                          ),
                        ],
                      )
                    : FlickVideoPlayer(
                        flickManager: FlickManager(
                          videoPlayerController:
                              VideoPlayerController.networkUrl(
                            Uri.parse(
                              item["url"].toString(),
                            ),
                          ),
                        ),
                      ),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              newPostProvider.setCurrentPhotoIndex(index);
            },
          ),
        ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: newPostProvider.media.asMap().entries.map((entry) {
        //       return InkWell(
        //           onTap: () {
        //             newPostProvider.removeMediaAtIndex(
        //                 newPostProvider.media.indexOf(entry.value));
        //           },
        //           child: Icon(
        //             Icons.delete,
        //             color: Colors.red,
        //           ));
        //     }).toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: newPostProvider.media.asMap().entries.map((entry) {
            return GestureDetector(
              // onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(
                    newPostProvider.currentPhotoIndex == entry.key ? 0.9 : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
