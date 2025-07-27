import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/common/bottom_nav.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/default_button.dart';
import '../utilities/app_image.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = './NotificationScreen';
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationList> list = [
    NotificationList(
        name: "Baseketball",
        image: "assets/icon/ic_logo_1024_c2.png",
        details: '43-44 B Sarvanand Nagar Near Meera Garden Indra 452014',
        date: '26 Nov, 2022',
        time: '5 min ago'),
    NotificationList(
        name: "Table Tennis",
        image: "assets/icon/ic_logo_1024_c2.png",
        details: 'Scheme 103,Indore,Madhya Predesh 452012',
        date: '20 Nov, 2022',
        time: '10 min ago'),
    NotificationList(
        name: "Badminton",
        image: "assets/icon/ic_logo_1024_c2.png",
        details:
            '3194E,E Sector,Sector E,Sudama Nagar, Indore,Madhya Predesh 452012',
        date: '19 Nov, 2022',
        time: '30 min ago'),
    NotificationList(
        name: "Badminton",
        image: "assets/icon/ic_logo_1024_c2.png",
        details: 'You have successfully shared your booking details',
        date: '18 Nov 2022',
        time: '10 min ago'),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: Constant.systemUiOverlayStyle,
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text(AppLanguage.NotificationsText[language],
              style: Constant.appBarCenterTitleStyle),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 95 / 100,
                      child: ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  1.3 /
                                  100,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFDFFFF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                16 /
                                                100,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                16 /
                                                100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: const Color(
                                                    0xffcccccc,
                                                  )),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      100), //<-- SEE HERE
                                            ),
                                            child: SizedBox(
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    14 /
                                                    100,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    14 /
                                                    100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100), //<-- SEE HERE
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                      AppImage.appLogo,
                                                    ),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.3 /
                                              100,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  70 /
                                                  100,
                                              color: Colors.white,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 1),
                                                child: Text(
                                                  list[index].name,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  70 /
                                                  100,
                                              color: Colors.white,
                                              child: Text.rich(
                                                TextSpan(
                                                  text: list[index].details,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffA79C9C),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4 /
                                                  100,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  70 /
                                                  100,
                                              color: Colors.white,
                                              child: Text(
                                                list[index].date,
                                                style: const TextStyle(
                                                    color: AppColor.themeColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4 /
                                                  100,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  70 /
                                                  100,
                                              color: Colors.white,
                                              child: Text(
                                                list[index].time,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNav(
            selectedMenu: MenuState.notification, notificationCount: 0),
      ),
    );
  }
}

class NotificationList {
  String name, image, details, date, time;
  NotificationList({
    required this.name,
    required this.image,
    required this.details,
    required this.date,
    required this.time,
  });
}
