import 'package:flutter/material.dart';
import 'package:nada_dco/utilities/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'dart:ui';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // Start with Home
  String? _userId;
  bool _isLoading = true;

  // This holds a SINGLE INSTANCE of each page.
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndInitialize();
  }

  Future<void> _loadUserIdAndInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedId = prefs.getInt('user_id');

    if (mounted) {
      setState(() {
        _userId = loadedId?.toString();

        // IMPORTANT: Initialize the pages list AFTER userId is loaded.
        _pages = <Widget>[
          const NotificationScreen(),
          Home(userId: _userId!),
          Profile(userId: _userId!),
        ];

        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColor.accent,)));
    }

    return Scaffold(
      extendBody: true, // This makes the body draw behind the floating navbar
      backgroundColor: AppColor.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: AppTheme.nueshadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: NavigationBar(
              backgroundColor: Colors.white.withOpacity(0.85),
              indicatorColor: AppColor.accent.withOpacity(0.2),
              surfaceTintColor: AppColor.card,
              height: 65,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                // This is the new, correct navigation logic.
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const <Widget>[
                NavigationDestination(
                  label: 'Notifications',
                  icon: Icon(Icons.notifications_none_outlined, color: AppColor.textSecondary),
                  selectedIcon: Icon(Icons.notifications, color: AppColor.textPrimary),
                ),
                NavigationDestination(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined, color: AppColor.textSecondary),
                  selectedIcon: Icon(Icons.home, color: AppColor.textPrimary),
                ),
                NavigationDestination(
                  label: 'Profile',
                  icon: Icon(Icons.person_outline, color: AppColor.textSecondary),
                  selectedIcon: Icon(Icons.person, color: AppColor.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}