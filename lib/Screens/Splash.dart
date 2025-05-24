import 'package:nada_dco/utilities/app_image.dart';
import 'package:flutter/material.dart';
import 'package:nada_dco/Screens/Login.dart';

class Splash extends StatefulWidget {
  Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override

  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login(title: "")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 60 / 100,
            height: MediaQuery.of(context).size.height * 60 / 100,
            child: Image.asset(AppImage.appLogo),
          ),
        ),
      ),
    );
  }
}