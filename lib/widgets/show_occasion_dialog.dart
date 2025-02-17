import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/new_post_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

Future<String?> showOccasionEditingDialog(
    fluent_ui.BuildContext context, NewPostProvider newPostProvider) {
  return showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      actions: [
        fluent_ui.Button(
          child: FittedBox(
            child: Text(
              'Change Occasion',
              style: AppStyle.styleRegular20(context)
                  .copyWith(color: Colors.white),
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            showOccasionDialog(context, newPostProvider);
          },
        ),
        fluent_ui.Button(
          child: FittedBox(
            child: Text(
              'Remove Occasion',
              style: AppStyle.styleRegular20(context)
                  .copyWith(color: Colors.white),
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            newPostProvider.setIsOcassionSelected(false);
          },
        ),
      ],
    ),
  );
}

Future<String?> showOccasionDialog(
    BuildContext context, NewPostProvider newPostProvider) {
  return showDialog<String>(
    context: context,
    builder: (context) => fluent_ui.ContentDialog(
      title: Text(
        "Occasion",
        style: AppStyle.styleRegular20(context).copyWith(color: Colors.white),
      ),
      content: Consumer<NewPostProvider>(builder: (context, myProvider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fluent_ui.ComboBox<String>(
                  value: myProvider.selectedOccasion,
                  items: myProvider.getOccasionsOptions(context).map((e) {
                    return fluent_ui.ComboBoxItem(
                      value: e["value"].toString(),
                      child: Text(
                        e["label"].toString(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    newPostProvider.setSelectedOccasion(
                      value,
                    );
                  },
                ),
              ],
            ),
          ],
        );
      }),
      actions: [
        fluent_ui.Button(
          child: Text(
            'Confirm',
            style:
                AppStyle.styleRegular20(context).copyWith(color: Colors.white),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            newPostProvider.setIsOcassionSelected(true);
          },
        ),
        fluent_ui.Button(
          child: Text(
            'Cancel',
            style:
                AppStyle.styleRegular20(context).copyWith(color: Colors.white),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
