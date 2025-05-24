import 'package:nada_dco/Screens/AttendanceSubCategory.dart';
import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/widgets.dart';
import 'package:flutter/material.dart';

import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class ViewAttendanceDetail extends StatefulWidget {
  static String routeName = '/view_attendance_details';
  const ViewAttendanceDetail({Key? key}) : super(key: key);

  @override
  State<ViewAttendanceDetail> createState() => _ViewAttendanceDetailState();
}

class _ViewAttendanceDetailState extends State<ViewAttendanceDetail> {
  List<AttendanceList> list = [
    AttendanceList(
        name: AppLanguage.OlympicGameText[language],
        image: AppImage.userImage,
        time: '22 Nov,2022',
        eventdate: AppLanguage.EventDateText[language]),
    AttendanceList(
        name: AppLanguage.basketballText[language],
        image: AppImage.userImage,
        time: '24 Nov,2022',
        eventdate: AppLanguage.EventDateText[language]),
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
                  MaterialPageRoute(
                      builder: (context) => const AttendanceSubCategory()),
                );
              },
            )),
        title: Text(AppLanguage.ViewattendanceDetailsText[language],
            style: Constant.appBarCenterTitleStyle),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _showListBottomSheet(context, AppLanguage.SelectEventText[language], eventList, 1, true);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: MediaQuery.of(context).size.width * 8 / 100,
              height: MediaQuery.of(context).size.width * 8 / 100,
              child: Image.asset(
                AppImage.eventCalenderIcon,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 8),
        width: double.infinity,
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                width: MediaQuery.of(context).size.width * 90 / 100,
                height: MediaQuery.of(context).size.height * 35 / 100,
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
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xffE3f5AB), Colors.white],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            list[index].name,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 2 / 100),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffC6D595), width: 1.0),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 2 / 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            list[index].eventdate,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 1 / 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            list[index].time,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.width * 3.0 / 100),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(list[index].image),
                              fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  getProportionateScreenHeight(int i) {}

  getProportionateScreenWidth(int i) {}

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
                        top: MediaQuery.of(context).size.width * 12 / 100),
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
                                ?
                                 Container(
                                   width: MediaQuery.of(context).size.width *
                                       90 /
                                       100,
                                   height: MediaQuery.of(context).size.height *
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

                                                  eventList = data;
                                                  
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

class AttendanceList {
  String name, image, eventdate, time;
  AttendanceList({
    required this.name,
    required this.image,
    required this.eventdate,
    required this.time,
  });
}
