import 'package:nada_dco/Screens/EducationAwarenessRights.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';

class EducationAwareness extends StatefulWidget {
  static String routeName = './EducationAwareness';
  const EducationAwareness({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _EducationAwarenessState createState() => _EducationAwarenessState();
}

class _EducationAwarenessState extends State<EducationAwareness> {
  bool toggleButton = true;
  bool toggleButtonsecound = true;
  bool tab1 = true;
  bool tab2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
         systemOverlayStyle:Constant.systemUiOverlayStyle,
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
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            )),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 100 / 100,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 88 / 100,
                  child: Text(AppLanguage.LanguageText[language],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // toggleButton = !toggleButton;
                          tab1 = true;
                          tab2 = false;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 7 / 100,
                            height: MediaQuery.of(context).size.width * 7 / 100,
                            child: Image.asset(tab1 == false
                                ? AppImage.deactivateRadioIcon
                                : AppImage.activateRadioIcon),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                AppLanguage.EnglishText[language],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 7 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tab1 = false;
                          tab2 = true;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 7 / 100,
                            height: MediaQuery.of(context).size.width * 7 / 100,
                            child: Image.asset(tab2 == false
                                ? AppImage.deactivateRadioIcon
                                : AppImage.activateRadioIcon),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                AppLanguage.HindiText[language],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 100 / 100,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 100 / 100,
                            height:Constant.deviceType=="ios"? MediaQuery.of(context).size.height * 73.5 / 100:
                      MediaQuery.of(context).size.height *79 / 100,
                         padding: EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 7,
                                spreadRadius: 2,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                width: MediaQuery.of(context).size.width *
                                    90 /
                                    100,
                                height: MediaQuery.of(context).size.height *
                                  42 /
                                    100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(AppImage.certifyImage),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1/
                                    100,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width *
                                    90 /
                                    100,
                                height: MediaQuery.of(context).size.height *
                                    10 /
                                    100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 7,
                                      spreadRadius: 2,
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  AppLanguage.HelloDcopRightsText[language],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height *4/ 100,
                              ),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.pushNamed(context,
                                      EducationAwarenessRights.routeName);
                                }),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      6.0 /
                                      100,
                                  decoration: const BoxDecoration(
                                     color: AppColor.themeColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                   
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          AppLanguage.GetStartedText[language],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                6 /
                                                100,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                6 /
                                                100,
                                        child: Image.asset(AppImage.aerroicon),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 5 / 100,
                              ),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                }),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      6 /
                                      100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3, color:AppColor.themeColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          AppLanguage
                                              .GoBackToHomeText[language],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 1),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                6.0 /
                                                100,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                6 /
                                                100,
                                        child: Image.asset(
                                          AppImage.homeIcon,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ),
                                
                              ),
                               SizedBox(
                                height:
                                    MediaQuery.of(context).size.height *1 / 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
