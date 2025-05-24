import 'package:nada_dco/Screens/SampleDepositeSubCategory.dart';
import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import '../utilities/widgets.dart';
import 'Success.dart';

class DepositeSamples extends StatefulWidget {
  static String routeName = './DepositeSamples';
  const DepositeSamples({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _DepositeSamplesState createState() => _DepositeSamplesState();
}

class _DepositeSamplesState extends State<DepositeSamples> {
  List<dynamic> handedOverList = <dynamic>[
    {"status": false, "title": "Courier"},
    {"status": false, "title": "Lab"},
  ];
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
                Navigator.pushNamed(
                    context, SampleDepositeSubCategory.routeName);
              },
            )),
        title: Text(AppLanguage.DepositSamplesText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: Constant.deviceType == "ios"
                          ? MediaQuery.of(context).size.height *84 / 100
                          : MediaQuery.of(context).size.height *90 / 100,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 2 / 100),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
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
                                         style:Constant.textFilledStyle
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
                                          child: Image.asset(AppImage.aerroicon),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              width:
                                  MediaQuery.of(context).size.width * 88 / 100,
                              height: MediaQuery.of(context).size.height *
                                  0.1 /
                                  100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2.5 / 100),
                   
                   
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
                                width: MediaQuery.of(context).size.width *
                                    85 /
                                    100,
                                alignment: Alignment.centerLeft,
                                child: Center(
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.black),
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
                                          .EnterTotalSampleText[language],
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
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3.4 / 100),
                   
                  
                    Container(
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
                                    85 /
                                    100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Text(
                                      AppLanguage.HandedOverDateText[language],
                                      style: Constant.textFilledStyle
                                    )),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          7 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              7 /
                                              100,
                                      child: Image.asset(AppImage.calenderIcon),
                                    ),
                                  ],
                                ),
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
                     SizedBox(
                        height: MediaQuery.of(context).size.height * 3.4 / 100),
                    
                   
                    GestureDetector(
                      onTap: () {
                        _showListBottomSheet(
                            context,
                            AppLanguage.HandedOverToText[language],
                            handedOverList,
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
                                          AppLanguage.HandedOverToText[language],
                                          style: Constant.textFilledStyle,
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
                                          child: Image.asset(AppImage.aerroicon),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              width:
                                  MediaQuery.of(context).size.width * 88 / 100,
                              height: MediaQuery.of(context).size.height *
                                  0.1 /
                                  100,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3/ 100),
                   
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
                                width: MediaQuery.of(context).size.width *
                                    85 /
                                    100,
                                alignment: Alignment.centerLeft,
                                child: Center(
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.black),
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
                                          .PickerNameText[language],
                                      hintStyle: Constant.textFilledStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 1),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: DefaultButton(
                        text: "Submit",
                        onPress: () {
                          _showAlertDialog1(context);
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog1(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        AppLanguage.NoText[language],
        style:TextStyle(color: Colors.red)
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLanguage.YesText[language],
         style:TextStyle(color: Colors.black)),
      onPressed: () {
        Navigator.pushNamed(
          context,
          SuccessScreen.routeName,
          arguments: SuccessClass(
            message: AppLanguage.DepositeSuccessSampleTextText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "depositesample",
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(
        AppLanguage.DepositeCollectSampleModelText[language],
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
                      top: MediaQuery.of(context).size.width * 13 / 100),
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
                          SizedBox(height: 8),
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

                                                var handedOverList = data;
                                                // if (type == 1) {
                                                //   states = data;
                                                // } else if (type == 2) {
                                                //   cities = data;
                                                // } else if (type == 3) {
                                                //   employeeTypeList = data;
                                                // }
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
