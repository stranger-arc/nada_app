import 'dart:math';

import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class IdCardDetails extends StatefulWidget {
  static String routeName = './IdCardDetails';
  const IdCardDetails({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _IdCardDetailsState createState() => _IdCardDetailsState();
}

class _IdCardDetailsState extends State<IdCardDetails> {
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
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            )),
        title: Text(AppLanguage.IDCardText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 58 / 100,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // ),

                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  // margin: EdgeInsets.symmetric(horizontal: 15),
                                  width: MediaQuery.of(context).size.width *
                                      100 /
                                      100,
                                  height: MediaQuery.of(context).size.width *
                                      76 /
                                      100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14)),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff7fb06e),
                                        Color(0xff9dc660)
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                27 /
                                                100,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                27 /
                                                100,
                                        child:
                                            Image.asset(AppImage.AppLogoIcon),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2 /
                                                100,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                90 /
                                                100,
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLanguage
                                                  .NationalAntiDopingAgencyText[
                                              language],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                60 /
                                                100,
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLanguage
                                              .MinistryofYouthText[language],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1.4 /
                                                100,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                70 /
                                                100,
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLanguage.DCOOfficialText[language],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )),

                              Positioned(
                                bottom: MediaQuery.of(context).size.width *
                                    3.1 /
                                    100,
                                // top: 5,
                                width: MediaQuery.of(context).size.width *
                                    95 /
                                    100,
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        49 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        28 /
                                        100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(AppImage.userIdImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 70 / 100,
                          alignment: Alignment.center,
                          child: Text(
                            AppLanguage.DRAbayJoshiText[language],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.8 / 100,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          color: Color(0xfffafafa),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        18 /
                                        100,
                                    height: MediaQuery.of(context).size.width *
                                        16 /
                                        100,
                                    child: Image.asset(AppImage.signetureIcon),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLanguage.AAONADAText[language],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    21 /
                                    100,
                                height: MediaQuery.of(context).size.width *
                                    21 /
                                    100,
                                child: Image.asset(AppImage.scannerIcon),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
