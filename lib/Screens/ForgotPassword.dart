import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/utilities/app_color.dart';

import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:flutter/material.dart';

import '../utilities/app_language.dart';

class ForgotPassword extends StatefulWidget {
  static String routeName = './forgotPassword';
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 5 / 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(
                                title: "",
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              width: MediaQuery.of(context).size.width * 7 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 7 / 100,
                              child: Image.asset(AppImage.backicon),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 62 / 100,
                        height: MediaQuery.of(context).size.width *62 / 100,
                        child: Image.asset(AppImage.AppLogoIcon),
                      ),
                        SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * 6 / 100),
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height: MediaQuery.of(context).size.height * 34 / 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                             borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                               boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      70 /
                                      100,
                                  child: Text(
                                    AppLanguage.ForgotPasswordText[language],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        7 /
                                        100),
                                 Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            70 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                6 /
                                                100,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      2 /
                                                      100,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      6 /
                                                      100,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      6 /
                                                      100,
                                                  child: Image.asset(
                                                      AppImage.userprofileicon),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      55 /
                                                      100,
                                                  // height: MediaQuery.of(context)
                                                  //         .size
                                                  //         .height *
                                                  //     5.5 /
                                                  //     100,
                                                  decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                  ),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        color: AppColor
                                                            .secondaryColor),
                                                    keyboardType:
                                                        TextInputType.name,
                                                    maxLength: 50,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      fillColor:
                                                          AppColor.primaryColor,
                                                            contentPadding:
                                          EdgeInsets.only(bottom:0, left: 2,top:3),
                                                      filled: true,
                                                      counterText: '',
                                                      hintText: AppLanguage
                                                          .UsernameText[language],
                                                      hintStyle: const TextStyle(
                                                          color: AppColor
                                                              .texfilledColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  66 /
                                                  100,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1 /
                                                  100,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                 
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      SuccessScreen.routeName,
                                      arguments: SuccessClass(
                                          message: AppLanguage
                                              .ForgotSuccessScreenText[language],
                                          title:
                                              AppLanguage.SuccessText[language],
                                          screenName: "forgotscreen"),
                                    );
    
                                   
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        70 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        6 /
                                        100,
                                    decoration: const BoxDecoration(
                                      color:AppColor.themeColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLanguage.SendText[language],
                                      style: const TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    alignment: Alignment.center,
                    color: AppColor.themeColor,
                    child: Text(
                      AppLanguage.CopyrightText[language],
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
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
