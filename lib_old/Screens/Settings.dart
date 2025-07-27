import 'package:nada_dco/Screens/AboutUs.dart';
import 'package:nada_dco/Screens/ChangePassword.dart';
import 'package:nada_dco/Screens/Contactus.dart';
import 'package:nada_dco/Screens/DeleteAccount.dart';

import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/Privacypolicy.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/Screens/Termsandconditions.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  Settings({super.key, required this.title});
  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _showAlertDialog1(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(AppLanguage.NoText[language],
        style: TextStyle(color: Colors.red),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLanguage.YesText[language],
      style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              title: '',
            ),
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.LogoutModelText[language]),
      content: Text(AppLanguage.ExitLogout[language]),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            )),
        title: Text(AppLanguage.SettingsText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 94 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: Image.asset(AppImage.LockIcon),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child:
                                  Text(AppLanguage.ChangePasswordText[language],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff504F51),
                                        fontSize: 17,
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUs(
                                  title: "",
                                )),
                      );
                    },
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 94 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: Image.asset(AppImage.information),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child: Text(AppLanguage.AboutUsText[language],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff504F51),
                                    fontSize: 17,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Termsandconditions(
                                  title: "",
                                )),
                      );
                    },
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 94 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: Image.asset(AppImage.termsconditions),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child: Text(
                                  AppLanguage.TermsConditionsText[language],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff504F51),
                                    fontSize: 17,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Privacypolicy(
                                  title: "",
                                )),
                      );
                    },
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 94 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: Image.asset(AppImage.privacypolicy),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child:
                                  Text(AppLanguage.PrivacyPolicyText[language],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff504F51),
                                        fontSize: 17,
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Contactus(
                                  title: "",
                                )),
                      );
                    },
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 94 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: Image.asset(AppImage.phoneicon),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child: Text(AppLanguage.ContactUsText[language],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff504F51),
                                    fontSize: 17,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 94 / 100,
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            child: Image.asset(AppImage.shareicon),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            child: Text(AppLanguage.ShareAppText[language],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff504F51),
                                  fontSize: 17,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 94 / 100,
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            child: Image.asset(AppImage.rateapp),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            child: Text(AppLanguage.RateAppText[language],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff504F51),
                                  fontSize: 17,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccount(
                                  title: "",
                                )),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 94 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: Image.asset(AppImage.deleteicon),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child:
                                  Text(AppLanguage.DeleteAccountText[language],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff504F51),
                                        fontSize: 17,
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _showAlertDialog1(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: MediaQuery.of(context).size.width * 85 / 100,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  decoration: const BoxDecoration(
                      color: Color(0xffFFF5F5),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        child: Image.asset(AppImage.logouticon),
                      ),
                      Text(
                        AppLanguage.LogoutText[language],
                        style: const TextStyle(
                            color: Color(0xffff0000),
                            fontSize: 19,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
