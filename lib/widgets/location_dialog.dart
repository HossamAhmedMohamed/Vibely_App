import 'package:flutter/material.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:social_media_app/utils/pages_name.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

Future<String?> showLocationDialog(fluent_ui.BuildContext context, NewPostProvider newPostProvider) {
    return showDialog<String>(
                            context: context,
                            builder: (context) => fluent_ui.ContentDialog(
                              actions: [
                                fluent_ui.Button(
                                  child: FittedBox(
                                    child: Text(
                                      'View My Location',
                                      style: AppStyle.styleRegular20(context)
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, locationScreen);
                                  },
                                ),
                                fluent_ui.Button(
                                  child: FittedBox(
                                    child: Text(
                                      'Remove Location',
                                      style: AppStyle.styleRegular20(context)
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    newPostProvider.removeLocationData();
                                  },
                                ),
                              ],
                            ),
                          );
  }