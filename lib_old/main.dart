import 'package:flutter/material.dart';
import 'package:nada_dco/Screens/Splash.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/routes.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Check auth status before running the app
  final prefs = await SharedPreferences.getInstance();
  final isAuthenticated = prefs.getInt('user_id') != null;

  runApp(MyApp(isAuthenticated: isAuthenticated));
}

class MyApp extends StatefulWidget {
  final bool isAuthenticated;

  const MyApp({super.key, required this.isAuthenticated});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isAuthenticated;

  @override
  void initState() {
    super.initState();
    _isAuthenticated = widget.isAuthenticated;
  }

  // This can be called from anywhere in the app to update auth state
  Future<void> updateAuthStatus(bool isAuthenticated) async {
    setState(() {
      _isAuthenticated = isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DCO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppFont.fontFamily,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xffD5F274),
        ),
      ),
      routes: routes,
      home: _isAuthenticated ?  Home() :  Splash(),
      // Pass the update function to all routes that might need it
      onGenerateRoute: (settings) {
        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(
            builder: (context) => builder(context),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}