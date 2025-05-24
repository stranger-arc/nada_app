import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Settings.dart';
import 'package:nada_dco/Screens/Sorry.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';

import '../common/default_button.dart';

class DeleteAccount extends StatefulWidget {
  DeleteAccount({super.key, required this.title});

  final String title;
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          systemOverlayStyle: Constant.systemUiOverlayStyle,
          leading: InkWell(
              onTap: () {},
              child: IconButton(
                icon: Image.asset(
                  AppImage.backicon,
                  height: 25,
                  width: 25,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Settings(
                              title: "",
                            )),
                  );
                },
              )),
          title: Text(AppLanguage.DeleteAccountText[language],
              style: Constant.appBarCenterTitleStyle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2.8 / 100),
                    Container(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.black,
                          cursorHeight: 20.0,
                          maxLines: 5,
                          maxLength: 250,
                          decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              hintText: AppLanguage.ReasonText[language],
                              hintStyle: Constant.textFilledStyle),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                    DefaultButton(
                      text: AppLanguage.SubmitText[language],
                      onPress: () {
                        Navigator.pushNamed(context, Sorry.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
