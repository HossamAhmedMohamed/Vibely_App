// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/home_screen_provider.dart';
import 'package:social_media_app/providers/profile_tap_provider.dart';
import 'package:social_media_app/screens/taps/friends/friends_tap.dart';
import 'package:social_media_app/screens/taps/home/home_tap.dart';
import 'package:social_media_app/screens/taps/notifications/notifications_tap.dart';
import 'package:social_media_app/screens/taps/profile/profile_tap.dart';
import 'package:social_media_app/screens/taps/videos/videos_tap.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PersistentTabController _controller = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    final isVisible = Provider.of<HomeScreenProvider>(context);
    return PersistentTabView(
      context,
      controller: _controller,
      onItemSelected: (value) {
            print(value);
            if (value == 4) {
              final profileTabProvider = Provider.of<ProfileTapProvider>(
                context,
                listen: false,
              );
    
              profileTabProvider.getData();
            }
          },
      screens: [
        HomeTap(),
        FriendsTap(),
        VideosTap(),
        NotificationsTap(),
        ProfileTap(),
      ],
      items: [
         PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,           
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.group),
                title: ("Friends"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
                 
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.video_camera),
                title: ("Videos"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
                 
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.bell),
                title: ("Notifications"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
                 
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.person),
                title: ("Profile"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
                 
            ),
    
      ],
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.grey.shade900,
      isVisible: isVisible.isVisible,
      // animationSettings: const NavBarAnimationSettings(
      //   navBarItemAnimation: ItemAnimationSettings(
      //     // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 400),
      //     curve: Curves.ease,
      //   ),
      //   screenTransitionAnimation: ScreenTransitionAnimationSettings(
      //     // Screen transition animation on change of selected tab.
      //     animateTabTransition: true,
      //     duration: Duration(milliseconds: 200),
      //     screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
      //   ),
      // ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property
    );
  }
}
