import 'package:flutter/material.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
    required this.selectedMenu,
    this.notificationCount = 0,
  }) : super(key: key);

  final MenuState selectedMenu;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    int getSelectedIndex(MenuState menu) {
      switch (menu) {
        case MenuState.notification: return 0;
        case MenuState.home: return 1;
        case MenuState.profile: return 2;
      }
    }

    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.nueshadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: AppColor.accent.withOpacity(0.2),
          surfaceTintColor: AppColor.card,
          height: 65,
          selectedIndex: getSelectedIndex(selectedMenu),
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) => TextStyle(
              color: states.contains(MaterialState.selected)
                  ? AppColor.accent
                  : AppColor.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          onDestinationSelected: (int index) {
            if (index == 0 && selectedMenu != MenuState.notification) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
            } else if (index == 1 && selectedMenu != MenuState.home) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
            } else if (index == 2 && selectedMenu != MenuState.profile) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
            }
          },
          destinations: <Widget>[
            NavigationDestination(
              label: 'Notifications',
              // FIXED: Explicitly setting icon colors for readability
              icon: Icon(Icons.notifications_none_outlined, color: AppColor.textSecondary),
              selectedIcon: Icon(Icons.notifications, color: AppColor.accent),
            ),
            NavigationDestination(
              label: 'Home',
              // FIXED: Explicitly setting icon colors for readability
              icon: Icon(Icons.home_outlined, color: AppColor.textSecondary),
              selectedIcon: Icon(Icons.home, color: AppColor.accent),
            ),
            NavigationDestination(
              label: 'Profile',
              // FIXED: Explicitly setting icon colors for readability
              icon: Icon(Icons.person_outline, color: AppColor.textSecondary),
              selectedIcon: Icon(Icons.person, color: AppColor.accent),
            ),
          ],
        ),
      ),
    );
  }
}