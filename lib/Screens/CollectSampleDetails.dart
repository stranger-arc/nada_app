import 'package:nada_dco/Screens/SampleCollectionSubCategory.dart';

import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import '../utilities/widgets.dart';
import 'Success.dart';

class CollectSampleDetails extends StatefulWidget {
  static String routeName = './CollectSampleDetails';
  const CollectSampleDetails({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CollectSampleDetailsState createState() => _CollectSampleDetailsState();
}

class _CollectSampleDetailsState extends State<CollectSampleDetails> {
  List<SampleCollectList> list = [
    SampleCollectList(
        name: AppLanguage.MichaelJordenText[language],
        eventName: 'Boxing',
        total: '22',
        type: 'Blood'),
    SampleCollectList(
        name: AppLanguage.MichaelJordenText[language],
        eventName: 'Basketball',
        total: '44',
        type: 'Blood'),
    SampleCollectList(
        name: AppLanguage.MichaelJordenText[language],
        eventName: 'Table Tennis',
        total: '51',
        type: 'Blood'),
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
  List<dynamic> selectSample = <dynamic>[
    {"status": false, "title": "Blood"},
    {"status": false, "title": "Urine"},
    {"status": false, "title": "Basic metabolic panel"},
    {"status": false, "title": "Comprehensive metabolic panel"},
    {"status": false, "title": "Lipid panel"},
    {"status": false, "title": "Thyroid panel"},
    {"status": false, "title": "Cardiac biomarkers"},
    {"status": false, "title": "C-reactive protein test"},
    {"status": false, "title": "liver function test"},
    {"status": false, "title": "Thyroid function test"},
    {"status": false, "title": "Basic metabolic panel"},
    {"status": false, "title": "Comprehensive metaboilc panel"},
    {"status": false, "title": "Formula One Racing"},
    {"status": false, "title": "Lipid panel"},
    {"status": false, "title": "Thyroid panel"},
    {"status": false, "title": "Cardiac biomarkers"},
  ];
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
        Navigator.pushNamed(
          context,
          SuccessScreen.routeName,
          arguments: SuccessClass(
            message: AppLanguage.CollectSampleSuccessText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "collectsampledetails",
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(
        AppLanguage.CollectSamplesModelText[language],
      ),
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
                Navigator.pushNamed(
                    context, SampleCollectionSubCategory.routeName);
              },
            )),
        title: Text(AppLanguage.CollectSampleText[language],
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
                GestureDetector(
                  onTap: () {
                    _showListBottomSheet(
                        context,
                        AppLanguage.SelectEventText[language],
                        eventList,
                        1,
                        true);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    height: MediaQuery.of(context).size.height * 6 / 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguage.SelectEventText[language],
                                       style: Constant.textFilledStyle
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          6 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              6 /
                                              100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                )),
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
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),
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
                          Container(
                            width: MediaQuery.of(context).size.width * 85 / 100,
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                //  textAlign: TextAlign.center,
                                maxLength: 50,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 2.0, left: 8),
                                  counterText: '',
                                  hintText:
                                      AppLanguage.EnterSampleCodeText[language],
                                  hintStyle: Constant.textFilledStyle
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 3 / 100),
               
            
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
                          Container(
                            width: MediaQuery.of(context).size.width * 85 / 100,
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                //  textAlign: TextAlign.center,
                                maxLength: 50,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 2.0, left: 8),
                                  counterText: '',
                                  hintText: AppLanguage
                                      .AthleteNameText[language],
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 4 / 100),
                
                GestureDetector(
                  onTap: () {
                    _showListBottomSheet(
                        context,
                        AppLanguage.SampleTypeText[language],
                        selectSample,
                        1,
                        true);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    height: MediaQuery.of(context).size.height * 6 / 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguage
                                          .SelectSampleTypeText[language],
                                      style: Constant.textFilledStyle
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          6 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              6 /
                                              100,
                                      child: Image.asset(AppImage.aerroicon),
                                    ),
                                  ],
                                )),
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
                SizedBox(height: MediaQuery.of(context).size.height * 4 / 100),
                DefaultButton(
                    text: AppLanguage.SubmitText[language],
                    onPress: () {
                      _showAlertDialog1(context);
                    }),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 2.2 / 100),
                Container(
                  width: MediaQuery.of(context).size.width * 88 / 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLanguage.RecentCollectedSamplesText[language],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 6 / 100,
                        height: MediaQuery.of(context).size.width * 6 / 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color:AppColor.themeColor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "3",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1.5 / 100,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            height:
                                MediaQuery.of(context).size.height * 15 / 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ViewCollectSampleDetailRow(
                                      title1: AppLanguage.EventText[language],
                                      title2: list[index].eventName),
                                  ViewCollectSampleDetailRow(
                                      title1:
                                          AppLanguage.SampleCodeText[language],
                                      title2: list[index].total),
                                  ViewCollectSampleDetailRow(
                                      title1:
                                          AppLanguage.AthleteNameText[language],
                                      title2: list[index].name),
                                  ViewCollectSampleDetailRow(
                                      title1:
                                          AppLanguage.SampleTypeText[language],
                                      title2: list[index].type),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ViewCollectSampleDetailRow extends StatelessWidget {
  ViewCollectSampleDetailRow({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title1.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
        Text(
          title2.toString(),
          style: const TextStyle(
              color: Color(0xff948e8e), fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class SampleCollectList {
  String name, eventName, total, type;
  SampleCollectList(
      {required this.name,
      required this.eventName,
      required this.total,
      required this.type});
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
                      top: MediaQuery.of(context).size.width * 12/ 100),
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
                            width: MediaQuery.of(context).size.width * 6 / 100,
                            height: MediaQuery.of(context).size.width * 6 / 100,
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                              onTap: () {
                                                var data = dataList;
                                                for (int i = 0;
                                                    i < data.length;
                                                    i++) {
                                                  data[i]['status'] = false;
                                                }
                                                data[index]['status'] = true;

                                                var selectSample = data;

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
