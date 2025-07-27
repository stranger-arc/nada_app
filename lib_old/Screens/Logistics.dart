import 'package:nada_dco/Screens/LogisticsSubCategory.dart';
import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class Logistics extends StatefulWidget {
  static String routeName = './Logistics';
  const Logistics({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LogisticsState createState() => _LogisticsState();
}

class _LogisticsState extends State<Logistics> {
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
        Navigator.pushNamed(
          context,
          SuccessScreen.routeName,
          arguments: SuccessClass(
            message: AppLanguage.LogisticsSuccessText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "viewlogisticdetailscreen",
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(AppLanguage.LogisticsModelText[language]),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LogisticsSubCategory()),
                );
              },
            )),
        title: Text(AppLanguage.LogisticsText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 100 / 100,
          height: MediaQuery.of(context).size.height * 100 / 100,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLanguage.SelectEventText[language],
                                        style: Constant.textFilledStyle,
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
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 94 / 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 24 / 100,
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              AppLanguage.ItemNameText[language],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 30 / 100,
                            child: Text(
                              AppLanguage.AvailableUnitsText[language],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 30 / 100,
                            child: Text(
                              AppLanguage.RequestedUnitsText[language],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 94 / 100,
                    child: Column(
                      children: [
                        LogisticsView(
                            title1: AppLanguage.BottiesText[language]),
                        LogisticsView(title1: AppLanguage.BookText[language]),
                        LogisticsView(title1: AppLanguage.NetsText[language]),
                        LogisticsView(title1: AppLanguage.SticksText[language]),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DefaultButton(
                    text: AppLanguage.SubmitText[language],
                    onPress: () {
                      _showAlertDialog1(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LogisticsView extends StatelessWidget {
  LogisticsView({
    Key? key,
    required this.title1,
  }) : super(key: key);
  final String title1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          width: MediaQuery.of(context).size.width * 94 / 100,
          height: MediaQuery.of(context).size.width * 9 / 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 20 / 100,
                child: Text(
                  title1.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 28 / 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      maxLength: 7,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                        fillColor: Colors.white,
                        filled: true,
                        counterText: '',
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      width: MediaQuery.of(context).size.width * 28 / 100,
                      height: MediaQuery.of(context).size.height * 0.1 / 100,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 28 / 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      maxLength: 7,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                        fillColor: Colors.white,
                        filled: true,
                        counterText: '',
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      width: MediaQuery.of(context).size.width * 28 / 100,
                      height: MediaQuery.of(context).size.height * 0.1 / 100,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
