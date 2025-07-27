import 'package:nada_dco/Screens/EducationAwareness.dart';
import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/Screens/IdCardDetails.dart';
import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/LogisticsSubCategory.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/SampleCollectionSubCategory.dart';
import 'package:nada_dco/Screens/SampleDepositeSubCategory.dart';
import 'package:nada_dco/Screens/TravelSubCategory.dart';
import 'package:nada_dco/Screens/AttendanceSubCategory.dart';
import 'package:nada_dco/common/bottom_nav.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }


  _showAlertDialog1(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        AppLanguage.NoText[language],
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        AppLanguage.YesText[language],
        style: TextStyle(color: Colors.black),
      ),
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

  List<Eventlist> event = [
    Eventlist(
        name: AppLanguage.EventsText[language], image: AppImage.Eventicon),
    Eventlist(
        name: AppLanguage.TravelPlanText[language], image: AppImage.TravelIcon),
    Eventlist(
        name: AppLanguage.LogisticsText[language],
        image: AppImage.LogisticsIcon),
    Eventlist(
        name: AppLanguage.AttendanceText[language],
        image: AppImage.AttendanceIcon),
    Eventlist(
        name: AppLanguage.SampleCollectionText[language],
        image: AppImage.SampcollectionIcon),
    Eventlist(
        name: AppLanguage.SampleDepositeText[language],
        image: AppImage.SampledepositIcon),
    Eventlist(
        name: AppLanguage.EducationAwarenessText[language],
        image: AppImage.Education_Icon),
  ];

  void navigateToNextScreen(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EventSubCategory(),
        ),
      );
    }
    if (index == 1) {
      Navigator.pushNamed(context, TravelSubCategory.routeName);
    }
    if (index == 2) {
      Navigator.pushNamed(context, LogisticsSubCategory.routeName);
    }
    if (index == 3) {
      Navigator.pushNamed(context, AttendanceSubCategory.routeName);
    }
    if (index == 4) {
      Navigator.pushNamed(context, SampleCollectionSubCategory.routeName);
    }
    if (index == 5) {
      Navigator.pushNamed(context, SampleDepositeSubCategory.routeName);
    }
    if (index == 6) {
      Navigator.pushNamed(context, EducationAwareness.routeName);
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _performLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  Login(title: 'Logout Successfull',)),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout error: ${e.toString()}')),
      );
    }
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        AppLanguage.NoText[language],
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        AppLanguage.YesText[language],
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(AppLanguage.ExitAppText[language]),
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

  Future<void> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'No email found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _showAlertDialog(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 90 / 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 95 / 100,
                      height: MediaQuery.of(context).size.height * 12.35 / 100,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.7, color: Color(0xffBFBCBC)),
                                borderRadius:
                                    BorderRadius.circular(100), //<-- SEE HERE
                                image: const DecorationImage(
                                  image: AssetImage(AppImage.UserProfileImage),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            height:
                                MediaQuery.of(context).size.width * 13 / 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                40 /
                                                100,
                                            child: Text(
                                                AppLanguage
                                                    .WelcomeBackText[language],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.5))),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                40 /
                                                100,
                                            child: Text(
                                                email,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 9.5))),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _showLogoutConfirmationDialog(context);
                                  },
                                  child: Image.asset(
                                    AppImage.logout,
                                    width: 42,
                                    height: 42,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 100 / 100,

                  height: Constant.deviceType == "ios"
                      ? MediaQuery.of(context).size.height * 68 / 100
                      : MediaQuery.of(context).size.height * 74 / 100,
                  //  color: const Color(0xfffaf9f9),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Heading(
                          title: AppLanguage.EventsText[language],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 63),
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14.0,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: List.generate(event.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  navigateToNextScreen(index);
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.centerRight,
                                      width: MediaQuery.of(context).size.width *
                                          44 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              13.5 /
                                              100,
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(
                                          'Container 1',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -32,
                                      width: MediaQuery.of(context).size.width *
                                          43 /
                                          100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                19 /
                                                100,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                19 /
                                                100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 1.2,
                                                  color: AppColor.themeColor),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                event[index].image,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    12 /
                                                    100,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    12 /
                                                    100,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1.9 /
                                                100,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(event[index].name,
                                                textAlign: TextAlign.center,
                                                style: Constant.homeTextStyle),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Heading(
                          title: AppLanguage.UserText[language],
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IdCardDetails()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            height:
                                MediaQuery.of(context).size.height * 18 / 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImage.userCardIcon,
                                  width: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                  height: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: Text(
                                    AppLanguage.IDCardText[language],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            const BottomNav(selectedMenu: MenuState.home, notificationCount: 0),
      ),
    );
  }
}

class Eventlist {
  String name, image;
  Eventlist({required this.name, required this.image});
}

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 100 / 100,
      height: MediaQuery.of(context).size.height * 6 / 100,
      alignment: Alignment.centerLeft,
      color: AppColor.themeColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppFont.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
    );
  }
}
