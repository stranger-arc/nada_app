
import 'package:nada_dco/Screens/Splash.dart';
import 'package:nada_dco/routes.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: Splash(),
    );
  }
}
