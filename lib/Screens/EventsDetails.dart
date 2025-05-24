import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utilities/app_constant.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class EventsDetails extends StatefulWidget {
  static String routeName = './EventsDetails';
  const EventsDetails({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
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
            message: AppLanguage.EventDetailsSuccessText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "eventdetailscreen",
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(
        AppLanguage.EventDetailsModelText[language],
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

  bool cancelButton = false;
  DateTime? initalDate;
  DateTime? selectedDate;
  String dateOfBirth = "MM/DD/YYYY";
  @override
  void initState() {
    super.initState();
    print(selectedDate);
    if (selectedDate == null) {
      dateOfBirth = "MM/DD/YYYY";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  MaterialPageRoute(builder: (context) => EventSubCategory()),
                );
              },
            )),
        title: Text(AppLanguage.ViewEventDetailsText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 7 / 100,
                          height: MediaQuery.of(context).size.width * 7 / 100,
                          child: Image.asset(
                            AppImage.DownloadIcon,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid),
                                ),
                              ),
                              margin: EdgeInsets.only(left: 1),
                              child: Text(
                                AppLanguage.DeploymentApprovelText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  // decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    color: AppColor.greyBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 94 / 100,
                          child: Text(
                            AppLanguage.TableTennisText[language],
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: AppFont.fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 95.5 / 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        AppImage.locationIcon,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        AppLanguage
                                            .NethajiIndoorStadiumText[language],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFont.fontFamily,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          4 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              4 /
                                              100,
                                      child: Image.asset(
                                        AppImage.calenderwhiteIcon,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5 /
                                          100,
                                    ),
                                    Container(
                                      child: Text(
                                        AppLanguage.EventsDateText[language],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFont.fontFamily,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    child: Text(AppLanguage.NovemberText[language],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  GestureDetector(
                    onTap: () {
                      cancelButton = !cancelButton;
                      setState(() {});
                    },
                    child: cancelButton
                        ? Container(
                            height:
                                MediaQuery.of(context).size.width * 53 / 100,
                            width: MediaQuery.of(context).size.width * 98 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                              AppImage.updatDateCalenderImage,
                            ))),
                          )
                        : Container(
                            height:
                                MediaQuery.of(context).size.width * 53 / 100,
                            width: MediaQuery.of(context).size.width * 99 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        AppImage.SelectDateCalenderImage))),
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cancelButton == false) {
                              _showAlertDialog1(context);
                            }
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 4.5 / 100,
                            width: MediaQuery.of(context).size.width * 46 / 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffFF0000),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                                AppLanguage.CancelAvilaibilityText[language],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.2 / 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2 / 100,
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    color: Color(0xffebebeb),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    color: AppColor.greyBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 94 / 100,
                          child: Text(
                            AppLanguage.HockeyText[language],
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: AppFont.fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 95.5 / 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        AppImage.locationIcon,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        AppLanguage
                                            .NethajiIndoorStadiumText[language],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFont.fontFamily,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          4 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              4 /
                                              100,
                                      child: Image.asset(
                                        AppImage.calenderwhiteIcon,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5 /
                                          100,
                                    ),
                                    Container(
                                      child: Text(
                                        AppLanguage.EventsDateText[language],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFont.fontFamily,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    child: Text(AppLanguage.DecemberText[language],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 53 / 100,
                    width: MediaQuery.of(context).size.width * 97 / 100,
                    child: Image.asset(
                      AppImage.calenderImage,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 4.5 / 100,
                          width: MediaQuery.of(context).size.width * 46 / 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffFF0000),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                              AppLanguage.CancelAvilaibilityText[language],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.1 / 100,
                    width: MediaQuery.of(context).size.width * 38 / 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2 / 100,
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    color: Color(0xffebebeb),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
