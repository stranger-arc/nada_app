import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';

class FootertWidget extends StatefulWidget {
  static String routeName = './FootertWidget';
  const FootertWidget({super.key});

  @override
  State<FootertWidget> createState() => _FootertWidgetState();
}

class _FootertWidgetState extends State<FootertWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    NotificationScreen(),
    Home(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff181715),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_selectedIndex == 0
                ? AppImage.activeNotificationIcon
                : AppImage.inactiveNotificationIcon)),
            label: AppLanguage.NotificationsText[language],
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
                _selectedIndex == 1 ? AppImage.activeHomeIcon : AppImage.inActiveHomeIcon)),
            label: AppLanguage.HomeText[language],
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_selectedIndex == 2
                ? AppImage.activeProfileIcon
                : AppImage.inActiveProfileicon)),
            label: AppLanguage.ProfileText[language],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        iconSize: 32,
        onTap: _onItemTapped,
      ),
    );
  }
}
