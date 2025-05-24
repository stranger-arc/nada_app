import 'dart:ffi';
import 'package:nada_dco/Screens/LocationScreen.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/Screens/SelectGender.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../common/default_button.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class EditProfile extends StatefulWidget {
  static String routeName = './EditProfile';
  const EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime? initalDate;
  DateTime? selectedDate;
  String dateOfBirth = "MM/DD/YYYY";

  List<dynamic> employeeTypeList = <dynamic>[
    {"status": false, "title": "Part-time employee"},
    {"status": false, "title": "Full-time employee"},
    {"status": false, "title": "Seasonal employee"},
    {"status": false, "title": "Temporary employee"},
    {"status": false, "title": "Leased employee"},
  ];

  List<dynamic> states = <dynamic>[
    {"status": false, "title": "Madhya Pradesh"},
    {"status": false, "title": "Maharashtra"},
    {"status": false, "title": "Sikkim"},
    {"status": false, "title": "Tamil Nadu"},
    {"status": false, "title": "Rajasthan"},
    {"status": false, "title": "Telangana"},
    {"status": false, "title": "Uttar Pradesh"},
    {"status": false, "title": "West Bengal"},
    {"status": false, "title": "Karnataka"},
    {"status": false, "title": "Jharkhand"},
    {"status": false, "title": "Gujarat "},
    {"status": false, "title": "Goa"},
  ];

  List<dynamic> cities = <dynamic>[
    {"status": false, "title": "Indore"},
    {"status": false, "title": "Bhopal"},
    {"status": false, "title": "Jabalpur"},
    {"status": false, "title": "Gwalior"},
    {"status": false, "title": "Ujjain"},
    {"status": false, "title": "Dewas"},
    {"status": false, "title": "Ratlam"},
    {"status": false, "title": "Rewa"},
    {"status": false, "title": "Katni"},
    {"status": false, "title": "Khandwa"},
    {"status": false, "title": "Shivpuri"},
    {"status": false, "title": "Vidisha"},
    {"status": false, "title": "Maharashtra"},
    {"status": false, "title": "Manipur"},
    {"status": false, "title": "Maghalaya"},
  ];

  List<dynamic> handedOverToList = <dynamic>[
    {"status": false, "title": "Courier"},
    {"status": false, "title": "Lab"},
  ];

  List<dynamic> eventList = <dynamic>[
    {"status": false, "title": "Olympic Game"},
    {"status": false, "title": "UEFA Champions League"},
    {"status": false, "title": "Cricket World Cup"},
    {"status": false, "title": "Super Bowl"},
    {"status": false, "title": "Wimbledon Tennis"},
    {"status": false, "title": "Tour de France Cycling"},
    {"status": false, "title": "Rugby World Cup"},
    {"status": false, "title": "Formula One Racing"},
    {"status": false, "title": "National Basketball"},
    {"status": false, "title": "Super Bowl"},
    {"status": false, "title": "Tour de France Cycling"},
    {"status": false, "title": "Rugby World Cup"},
    {"status": false, "title": "Formula One Racing"},
    {"status": false, "title": "National Basketball"},
    {"status": false, "title": "Super Bowl"},
  ];

  @override
  void initState() {
    super.initState();
    print(selectedDate);
    if (selectedDate == null) {
      dateOfBirth = "MM/DD/YYYY";
    }
  }

  employeeList(index) {
    print("Hello");
    var data = employeeTypeList;
    for (int i = 0; i < data.length; i++) {
      if (i == index) {
        data[index]['status'] = true;
      } else {
        data[index]['status'] = false;
      }
    }

    print(data);

    setState(() {
      employeeTypeList = data;
    });
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
          title:
               Text(AppLanguage.EditProfileText[language], style: Constant.appBarCenterTitleStyle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 100 / 100,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            height: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 5, color: Color(0xffe0e0e0)),
                              borderRadius:
                                  BorderRadius.circular(100), //<-- SEE HERE
    
                              image: const DecorationImage(
                                image: AssetImage(AppImage.UserProfileImage),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: MediaQuery.of(context).size.width * 31 / 100,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset(AppImage.cameraIcon),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 6 / 100,
                    ),
                    
    
                    Container(
                      //  padding: EdgeInsets.only(top:1),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.userprofileicon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 75 / 100,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                   textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.black,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      // contentPadding:
                                      //     EdgeInsets.only(bottom: 0, left: 8),
                                      hintText: AppLanguage
                                          .EnterFirstNameText[language],
                                      hintStyle: Constant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
    
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.8 / 100,
                    ),
    
                    Container(
                      //  padding: EdgeInsets.only(top:1),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.userprofileicon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 75 / 100,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.black,
                                   textAlignVertical: TextAlignVertical.center,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      // contentPadding:
                                      //     EdgeInsets.only(bottom: 2.0, left: 8),
                                      hintText:
                                          AppLanguage.EnterLastNameText[language],
                                      hintStyle: Constant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3.4/ 100,
                    ),
    
                    GestureDetector(
                      onTap: () {
                        _showDatePicker();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 6),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.height * 6 / 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 7 / 100,
                                  height:
                                      MediaQuery.of(context).size.width * 7 / 100,
                                  child: Image.asset(AppImage.calenderIcon),
                                ),
                                SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2.7 / 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      70 /
                                      100,
                                  alignment: Alignment.centerLeft,
                                  child: Text(dateOfBirth.toString(),
                                      style: Constant.textFilledStyle),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              width: MediaQuery.of(context).size.width * 88 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 / 100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.8 / 100,
                    ),
    
                    Container(
                      // padding: EdgeInsets.only(top:5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                 margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.callIcon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 78 / 100,
                                child: TextFormField(
                                  enabled: true,
                                  maxLength: 15,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                   textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      fillColor: Colors.white,
                                      filled: true,
                                      // contentPadding:
                                      //     EdgeInsets.only(bottom: 2.0, left: 8),
                                      // errorStyle: TextStyle(color: Colors.red),
                                      hintText: AppLanguage
                                          .PrimaryMobileNumberText[language],
                                      hintStyle: Constant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: ),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.8 / 100,
                    ),
    
                    Container(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                 margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.callIcon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                 margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 78 / 100,
                                child: TextFormField(
                                  enabled: true,
                                  maxLength: 15,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                   textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      // contentPadding:
                                      //     EdgeInsets.only(bottom: 2.0, left: 8),
                                      fillColor: Colors.white,
                                      filled: true,
                                      // errorStyle: TextStyle(color: Colors.red),
                                      hintText: AppLanguage
                                          .SecondaryMobileNoText[language],
                                      hintStyle: Constant.textFilledStyle),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                   
    
                    Container(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                 margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.emailIcon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 1),
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 78 / 100,
                                child: TextFormField(
                                  enabled: true,
                                  maxLength: 15,
                                  cursorColor: Colors.black,
                                   textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: '',
    
                                    fillColor: Colors.white,
                                    filled: true,
                                    // contentPadding:
                                    //     EdgeInsets.only(bottom: 2.0, left: 8),
                                    // errorStyle: TextStyle(color: Colors.red),
                                    hintText:
                                        AppLanguage.EnterEmailText[language],
                                    hintStyle: Constant.textFilledStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.6 / 100,
                    ),
    
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      //  height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2/ 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 8 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 8 / 100,
                                child: Image.asset(AppImage.locationIcon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2.7 / 100,
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          69 /
                                          100,
                                      height: MediaQuery.of(context).size.height *
                                          6 /
                                          100,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          AppLanguage.AddressText[language],
                                          style: Constant.textFilledStyle)),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        6.5 /
                                        100,
                                    height: MediaQuery.of(context).size.width *
                                        6.5 /
                                        100,
                                    child: Image.asset(AppImage.aerroicon),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                   
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.7/ 100,
                    ),
      Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      //  height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 8 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 8 / 100,
                                child: Image.asset(AppImage.locationIcon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2.7 / 100,
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          69 /
                                          100,
                                      height: MediaQuery.of(context).size.height *
                                          6 /
                                          100,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          AppLanguage.PermanentAddressText[language],
                                          style: Constant.textFilledStyle)),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        6.5 /
                                        100,
                                    height: MediaQuery.of(context).size.width *
                                        6.5 /
                                        100,
                                    child: Image.asset(AppImage.aerroicon),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                   
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.7 / 100,
                    ),
    
                    GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, SelectGender.routeName);
                      }),
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        //  height: MediaQuery.of(context).size.height * 6 / 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 7 / 100,
                                  height:
                                      MediaQuery.of(context).size.width * 7 / 100,
                                  child: Image.asset(AppImage.genderIcon),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3 / 100,
                                  height: MediaQuery.of(context).size.height *
                                      3.3 /
                                      100,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2.7 / 100,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            69 /
                                            100,
                                        height: MediaQuery.of(context).size.height *
                                            6 /
                                            100,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppLanguage.SelectGenderText[language],
                                          style: Constant.textFilledStyle,
                                        )),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      height: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              width: MediaQuery.of(context).size.width * 88 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 / 100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
    
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2.7 / 100),
                    GestureDetector(
                      onTap: () {
                        _showListBottomSheet(
                            context,
                            AppLanguage.SelectStateText[language],
                            states,
                            1,
                            true);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        //  height: MediaQuery.of(context).size.height * 6 / 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 8/ 100,
                                  height:
                                      MediaQuery.of(context).size.width * 8/ 100,
                                  child: Image.asset(AppImage.stateIcon),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1/ 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3.3 /
                                      100,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2.7/
                                      100,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            69 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                6 /
                                                100,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            AppLanguage.SelectStateText[language],
                                            style: Constant.textFilledStyle)),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      height: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              width: MediaQuery.of(context).size.width * 88 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 / 100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2.7 / 100,
                    ),
    
                    GestureDetector(
                      onTap: () {
                        _showListBottomSheet(
                            context,
                            AppLanguage.SelectCityText[language],
                            cities,
                            2,
                            true);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        //  height: MediaQuery.of(context).size.height * 6 / 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 7 / 100,
                                  height:
                                      MediaQuery.of(context).size.width * 7 / 100,
                                  child: Image.asset(AppImage.cityIcon),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3.3 /
                                      100,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2.7/
                                      100,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            69/
                                            100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                6 /
                                                100,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            AppLanguage.SelectCityText[language],
                                            style: Constant.textFilledStyle)),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      height: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              width: MediaQuery.of(context).size.width * 88 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 / 100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
    
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2.7 / 100),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, LocationScreen.routeName);
                      }),
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        //  height: MediaQuery.of(context).size.height * 6 / 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 8 / 100,
                                  height:
                                      MediaQuery.of(context).size.width * 8 / 100,
                                  child: Image.asset(AppImage.locationIcon),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3.3 /
                                      100,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2.7 /
                                      100,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            69 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                6 /
                                                100,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppLanguage.LocationText[language],
                                          style: Constant.textFilledStyle,
                                        )),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      height: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              width: MediaQuery.of(context).size.width * 88 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 / 100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
    
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2.7 / 100),
                    GestureDetector(
                      onTap: () {
                        _showListBottomSheet(
                            context,
                            AppLanguage.EmployeeTypeText[language],
                            employeeTypeList,
                            3,
                            false);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        //height: MediaQuery.of(context).size.height * 6/ 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 100,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 8 / 100,
                                  height:
                                      MediaQuery.of(context).size.width * 8 / 100,
                                  child: Image.asset(AppImage.employeeIcon),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3.3 /
                                      100,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2.7 /
                                      100,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            69 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                6 /
                                                100,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            AppLanguage
                                                .SelectEmployeeTypeText[language],
                                            style: Constant.textFilledStyle)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      height: MediaQuery.of(context).size.width *
                                          6.5 /
                                          100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              width: MediaQuery.of(context).size.width * 88 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 0.1 / 100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 8 / 100),
                    DefaultButton(
                      text: AppLanguage.UpdateText[language],
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile()),
                        );
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 7 / 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 28 / 100,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      AppLanguage.CancelText[language],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      selectedDate = null;
                      dateOfBirth = "MM/DD/YYYY";
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                      child: Text(
                        AppLanguage.DoneText[language],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      onPressed: () {
                        if (selectedDate != null) {
                          initalDate = selectedDate;
                          String date =
                              DateFormat('MM/dd/yyyy').format(selectedDate!);
                          dateOfBirth = date;
                          print(date);
                        }
                        Navigator.of(context).pop();
                        setState(() {});
                      }),
                ],
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  maximumDate: initalDate,
                  initialDateTime: initalDate,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime dateTime) {
                    selectedDate = dateTime;
                    print("selectedDate $selectedDate");
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showListBottomSheet(
      BuildContext context, String title, List dataList, type, bool status) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
                child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 13/ 100),
                    height: MediaQuery.of(context).size.height,
                    child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          centerTitle: true,
                          elevation: 1,
                          backgroundColor: Colors.white,
                          title: Text(
                            title.toString(),
                           style: Constant.appBarCenterTitleStyle
                          ),
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset(
                              AppImage.backicon,
                              width:
                                  MediaQuery.of(context).size.width * 6 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 6 / 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        body: Column(
                          children: [
                            SizedBox(height: 10),
                            status == true
                                ? Container(
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  height:
                                      MediaQuery.of(context).size.height *
                                          6.5 /
                                          100,
                                   decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
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
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Container(
                                            margin:
                                                EdgeInsets.only(left: 10),
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
                                                AppImage.searchIcon)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              75 /
                                              100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      25)),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            keyboardType:
                                                TextInputType.name,
                                            maxLength: 50,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                              filled: true,
                                              counterText: '',
                                              hintText: AppLanguage
                                                  .SearchText[language],
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                : Container(),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 12, bottom: 70),
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount: dataList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                                onTap: () {
                                                  var data = dataList;
                                                  for (int i = 0;
                                                      i < data.length;
                                                      i++) {
                                                    data[i]['status'] = false;
                                                  }
                                                  data[index]['status'] = true;
                                                  if (type == 1) {
                                                    states = data;
                                                  } else if (type == 2) {
                                                    cities = data;
                                                  } else if (type == 3) {
                                                    employeeTypeList = data;
                                                  }
                                                  setState(() {});
                                                },
                                                child: CustomRow(
                                                    title: dataList[index]
                                                        ['title'],
                                                    status: dataList[index]
                                                        ['status']));
                                          })),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 25),
                                          child: DefaultButton(
                                            text: AppLanguage
                                                .ContinueText[language],
                                            onPress: () {
                                              Navigator.pop(context);
                                            },
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        ))));
          });
        });
  }
}
