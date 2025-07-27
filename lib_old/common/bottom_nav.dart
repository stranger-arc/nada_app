import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav(
      {key, required this.selectedMenu, required this.notificationCount})
      : super(key: key);

  final MenuState selectedMenu;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Container(
       width: double.infinity,
     height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.height *12 / 100
                          : MediaQuery.of(context).size.height * 9 / 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (MenuState.notification != selectedMenu) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                }
              },
              child: Container(
                // padding: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 33.3 / 100,
                 height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.height *12 / 100
                          : MediaQuery.of(context).size.height * 9 / 100,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MenuState.notification == selectedMenu
                          ? AppImage.activeNotificationIcon
                          : AppImage.inactiveNotificationIcon,
                      width: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.width *8 / 100
                          : MediaQuery.of(context).size.width * 8 / 100,
                      height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.width * 8 / 100
                          : MediaQuery.of(context).size.width * 8 / 100,
                    ),
                   Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: AppFont.fontFamily,
                         color: MenuState.notification == selectedMenu ? AppColor.themeColor:Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (MenuState.home != selectedMenu) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }
              },
              child: Container(
                // padding: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 33.3 / 100,
                height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.height *12 / 100
                          : MediaQuery.of(context).size.height * 9 / 100,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MenuState.home == selectedMenu
                          ? AppImage.activeHomeIcon
                          : AppImage.inActiveHomeIcon,
                      width: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.width * 8 / 100
                          : MediaQuery.of(context).size.width * 8 / 100,
                      height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.width * 8/ 100
                          : MediaQuery.of(context).size.width * 8 / 100,
                    ),
                
                          Text(
                            "Home",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFont.fontFamily,
                                color: MenuState.home == selectedMenu ? AppColor.themeColor:Colors.grey,
                                fontWeight: FontWeight.w400),
                          )
                       
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (MenuState.profile != selectedMenu) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                }
              },
              child: Container(
                // padding: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 33.3 / 100,
                height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.height *12 / 100
                          : MediaQuery.of(context).size.height * 9 / 100,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MenuState.profile == selectedMenu
                          ? AppImage.activeProfileIcon
                          : AppImage.inActiveProfileicon,
                      width: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.width * 8 / 100
                          : MediaQuery.of(context).size.width * 8 / 100,
                      height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.width * 8 / 100
                          : MediaQuery.of(context).size.width * 8 / 100,
                    ),

                     Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFont.fontFamily,
                          color: MenuState.profile == selectedMenu ? AppColor.themeColor:Colors.grey,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
