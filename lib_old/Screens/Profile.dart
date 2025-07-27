import 'package:nada_dco/Screens/EditProfile.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Settings.dart';
import 'package:nada_dco/common/bottom_nav.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/app_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';
  String fname = '';
  String lname = '';
  String uname = '';
  String about = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'No email found';
      fname = prefs.getString('first_name') ?? 'No email found';
      lname = prefs.getString('last_name') ?? 'No email found';
      uname = prefs.getString('username') ?? 'No email found';
      about = prefs.getString('about') ?? 'No email found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(bottom:11),
                        width: MediaQuery.of(context).size.width * 100 / 100,
                        height: MediaQuery.of(context).size.width * 88 / 100,
                        decoration: const BoxDecoration(
                          //  color:Colors.red,
                          image: DecorationImage(
                            image: AssetImage(AppImage.myProfilebackgroundImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 25 / 100,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 50 / 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLanguage.ProfileText[language],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 25 / 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Settings(
                                                      title: "",
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width *
                                              9 /
                                              100,
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  9 /
                                                  100,
                                          child: Image.asset(
                                              AppImage.settingWhiteIcon,
                                              color: Colors.black,),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const EditProfile()),
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width *
                                              9 /
                                              100,
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  9 /
                                                  100,
                                          child:
                                              Image.asset(AppImage.editWhiteIcon,
                                               color: Colors.black,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 16.5 / 100,
                            ),
                           
                          ],
                        ),
                      ),
                   Positioned(
                    bottom: -1,
                      // bottom: MediaQuery.of(context).size.width*0/100,
                     child: Column(
                       children: [
                         Container(
                                    width: MediaQuery.of(context).size.width * 41 / 100,
                                    height: MediaQuery.of(context).size.width * 41 / 100,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(width: 5.2, color: Color(0xfffaf7f7)),
                                      borderRadius:
                                          BorderRadius.circular(100), //<-- SEE HERE
                   
                                      image: const DecorationImage(
                                        image: AssetImage(AppImage.UserProfileImage),
                                      ),
                                    ),
                                  ),
                                   SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100),
                                    Container(
                   
                    child: Text(
                      
                      fname + " " + lname,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),

                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2 / 100),
                  Container(
                    child: Text(
                      email,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                       ],
                     ),
                   ),
                    ],
                  ),
                
                  
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    width: double.infinity,
                    // height: ,
                    // color: Colors.red,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      margin: EdgeInsets.symmetric(vertical: 12),
                      width: MediaQuery.of(context).size.width * 95 / 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      // color: Colors.amberAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Profilecard(
                              title1: AppLanguage.GenderText[language],
                              title2: AppLanguage.MaleText[language]),
                          Profilecard(
                              title1: AppLanguage.DOBText[language],
                              title2: "02/22/1998"),
                          Profilecard(
                              title1:
                                  AppLanguage.PrimaryMobileNumberText[language],
                              title2: "+91 7856784596"),
                          Profilecard(
                              title1:
                                  AppLanguage.SecondaryMobileNoText[language],
                              title2: "+91 7856784596"),
                          Profilecard(
                              title1: AppLanguage.AddressText[language],
                              title2:
                                  "Mandir 1752-B, behind Ranjeet Hanuman Road, Maruti App.Opp.Ranjeet"),
                          Profilecard(
                              title1:
                                  AppLanguage.PermanentAddressText[language],
                              title2:
                                  "289, Prakhar Deep, Scheme, 97, Gopur Square, Indore, Madhya Pradesh 452009"),
                          Profilecard(
                              title1: AppLanguage.StateText[language],
                              title2: AppLanguage.MadhyaPradeshText[language]),
                          Profilecard(
                              title1: AppLanguage.CityText[language],
                              title2: AppLanguage.IndoreText[language]),
                          Profilecard(
                              title1: AppLanguage.LocationText[language],
                              title2:
                                  "PV74+GPV, Pandrinath Path, Gautampura, indore, Madhya Pradesh 452007"),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.6 / 100,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLanguage.EmployeeTypeText[language],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.6 / 100,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLanguage.ParttimeEmployeeText[language],
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1.5 / 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNav(
            selectedMenu: MenuState.profile, notificationCount: 0),
      ),
    );
  }
}

class Profilecard extends StatelessWidget {
  Profilecard({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6 / 100,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title1.toString(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6 / 100,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title2.toString(),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1.5 / 100,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 84 / 100,
          height: MediaQuery.of(context).size.height * 0.3 / 100,
          color: Color(0xffefefef),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5 / 100,
        ),
      ],
    );
  }
}
