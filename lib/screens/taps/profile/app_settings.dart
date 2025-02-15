import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/app_settings_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Language',
                    style: AppStyle.styleSemiBold25(context).copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  fluent_ui.ComboBox<String>(
                    value: Provider.of<AppSettingsProvider>(context)
                        .currentLanguage,
                    items: ['English', 'العربية'].map((e) {
                      return fluent_ui.ComboBoxItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
    
                      Provider.of<AppSettingsProvider>(context, listen: false)
                          .updateLanguage(value);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.sizeOf(context).width - 60) * 0.45,
                    child: Text(
                      'Theme mode',
                      style: AppStyle.styleSemiBold25(context).copyWith(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: CupertinoSwitch(
                      value: 
                      Provider.of<AppSettingsProvider>(context)
                          .isDark, // Boolean value indicating the current state of the switch
                      onChanged: (bool value) {
                        Provider.of<AppSettingsProvider>(context , listen: false)
                            .updateDarkMode(value , context);
                      },
                      activeTrackColor: CupertinoColors
                          .activeBlue, // Color when the switch is ON
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
