// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/controllers/posts_controller.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';

Future<String?> showPostPhotoDialog(BuildContext context, NewPostProvider newPostProvider) {
    return showDialog<String>(
                  context: context,
                  builder: (context) => fluent_ui.ContentDialog(
                    actions: [
                      fluent_ui.Button(
                        child: Text(
                          'Camera',
                          style: AppStyle.styleRegular20(context)
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          ImagePicker imagePicker = ImagePicker();

                          var file = await imagePicker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                          );

                          if (file == null) {
                            // Navigator.of(context).pop();
                            return;
                          }

                          // print("Photo >>>>>>>> " + file.name);
                          var uploadRes =
                              await PostsController.uploadPostMedia(
                            File(
                              file.path,
                            ),
                          );

                          print(uploadRes);

                          if (uploadRes["result"] == true) {
                            var url = uploadRes["url"];
                            var filename = uploadRes["filename"];

                            newPostProvider.addNewMedia({
                              "type": "photo",
                              "url": url,
                              "filename": filename,
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: uploadRes["message"].toString(),
                            );
                          }

                           
                        },
                      ),
                      fluent_ui.Button(
                        child: Text(
                          'Gallery',
                          style: AppStyle.styleRegular20(context)
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          ImagePicker imagePicker = ImagePicker();

                          var files = await imagePicker.pickMultiImage(
                            imageQuality: 50,
                          );

                          for (var file in files) {
                            var uploadRes =
                                await PostsController.uploadPostMedia(
                              File(
                                file.path,
                              ),
                            );

                            print(uploadRes);

                            if (uploadRes["result"] == true) {
                              var url = uploadRes["url"];
                              var filename = uploadRes["filename"];

                              newPostProvider.addNewMedia({
                                "type": "photo",
                                "url": url,
                                "filename": filename,
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: uploadRes["message"].toString(),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
  }



  //////////////////////////////////////////////////////////////////////
  ///
  
  Future<String?> showVideoPostDialog(BuildContext context, NewPostProvider newPostProvider) {
    return showDialog<String>(
                  context: context,
                  builder: (context) => fluent_ui.ContentDialog(
                    actions: [
                      fluent_ui.Button(
                        child: Text(
                          'Camera',
                          style: AppStyle.styleRegular20(context)
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          ImagePicker imagePicker = ImagePicker();
                          var file = await imagePicker.pickVideo(
                            source: ImageSource.camera,
                          );

                          if (file == null) {
                            // Navigator.of(context).pop();
                            return;
                          }

                          // print("Photo >>>>>>>> " + file.name);
                          var uploadRes =
                              await PostsController.uploadPostMedia(
                            File(
                              file.path,
                            ),
                          );

                          print(uploadRes);

                          if (uploadRes["result"] == true) {
                            var url = uploadRes["url"];
                            var filename = uploadRes["filename"];

                            newPostProvider.addNewMedia({
                              "type": "video",
                              "url": url,
                              "filename": filename,
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: uploadRes["message"].toString(),
                            );
                          }
                        },
                      ),
                      fluent_ui.Button(
                        child: Text(
                          'Gallery',
                          style: AppStyle.styleRegular20(context)
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();

                          var file = await imagePicker.pickVideo(
                            source: ImageSource.gallery,
                          );

                          if (file == null) {
                            Navigator.of(context).pop();
                            return;
                          }

                          Navigator.of(context).pop();

                          // print("Photo >>>>>>>> " + file.name);
                          var uploadRes =
                              await PostsController.uploadPostMedia(
                            File(
                              file.path,
                            ),
                          );

                          print(uploadRes);

                          if (uploadRes["result"] == true) {
                            var url = uploadRes["url"];
                            var filename = uploadRes["filename"];

                            newPostProvider.addNewMedia({
                              "type": "video",
                              "url": url,
                              "filename": filename,
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: uploadRes["message"].toString(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
  }
