import 'package:nada_dco/Screens/Login.dart';
import 'package:flutter/material.dart';

import '../common/default_button.dart';
import '../utilities/app_image.dart';

class Sorry extends StatefulWidget {
  static String routeName = './sorry';
  const Sorry({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SorryState createState() => _SorryState();
}

class _SorryState extends State<Sorry> {
  @override
  
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () {
         return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 130,
                    color: Colors.white,
                    child: Image.asset(
                      AppImage.sorryIcon,
                      width: 140,
                      height: 130,
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Sorry!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                    child: const Text(
                      "We are sorry to see you leave us.",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "We hope to see you again.",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  DefaultButton(
                    text: 'Done',
                    onPress: (){
                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login(title: "")),
                    );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
