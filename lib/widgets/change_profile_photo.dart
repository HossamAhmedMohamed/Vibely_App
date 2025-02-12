// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:path/path.dart' as path;

Future<String?> changePhotoDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      title: const Text('Change Profile Picture?'),
      content: const Text(
        'Choose the source that you want to get the new picture from',
      ),
      actions: [
        FilledButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: WidgetStateProperty.all(
              Colors.purple,
            ),
          ),
          onPressed: () async {
            ImagePicker imagePicker = ImagePicker();

            var file = await imagePicker.pickImage(
              source: ImageSource.camera,
              imageQuality: 50,
            );

            if (file != null) {
              // profileTabProvider.toggleLoading();

              try {
                String originalFilename = path.basename(file.path);
                // String extension = path.extension(file.path);
                String fileName =
                    "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";

                // print(fileName);
                Navigator.of(context, rootNavigator: true).pop();
                try {
                  await Supabase.instance.client.storage.from('users').upload(
                        fileName,
                        File(
                          file.path,
                        ),
                      );
                } catch (e) {
                  print(e.toString());
                }

                final String url =
                    Supabase.instance.client.storage.from("users").getPublicUrl(
                          fileName,
                        );

                

                await Provider.of<ProfileTapProvider>(context, listen: false)
                    .updateUserProfilePicture(
                  url,
                );
              } catch (e) {
                print(e.toString());
              }

              // profileTabProvider.toggleLoading();
            }
          },
          child: Row(
            children: [
              Icon(CupertinoIcons.camera),
              SizedBox(
                width: 5,
              ),
              Text(
                'Camera',
                style: AppStyle.styleSemiBold18(context)
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        FilledButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
          ),
          onPressed: () async {
            ImagePicker imagePicker = ImagePicker();

            var file = await imagePicker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
            );

            if (file != null) {
              // profileTabProvider.toggleLoading();

              try {
                String originalFilename = path.basename(file.path);
                // String extension = path.extension(file.path);
                String fileName =
                    "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";

                // print(fileName);

                try {
                  await Supabase.instance.client.storage.from('users').upload(
                        fileName,
                        File(
                          file.path,
                        ),
                      );
                } catch (e) {
                  print(e.toString());
                }

                final String url =
                    Supabase.instance.client.storage.from("users").getPublicUrl(
                          fileName,
                        );

                await Provider.of<ProfileTapProvider>(context, listen: false)
                    .updateUserProfilePicture(
                  url,
                );

                Navigator.of(context, rootNavigator: true).pop();
              } catch (e) {
                print(e.toString());
              }

              // profileTabProvider.toggleLoading();
            }
          },
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(
                width: 5,
              ),
              Text(
                'Gallery',
                style: AppStyle.styleSemiBold18(context)
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
