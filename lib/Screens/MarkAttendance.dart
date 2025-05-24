import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/Screens/AttendanceSubCategory.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../common/default_button.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class MarkAttendance extends StatefulWidget {
  static String routeName = './MarkAttendance';
  const MarkAttendance({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
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
            message: AppLanguage.MarkAttendanceSuccessText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "markattendancescreen",
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        AppLanguage.AreYouSureText[language],
      ),
      content: Text(
        AppLanguage.MarkAttendanceModelText[language],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AttendanceSubCategory()),
                );
              },
            )),
        title: Text(AppLanguage.MarkAttendanceText[language],
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
                                      style: Constant.textFilledStyle,
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
                Container(
                  height: MediaQuery.of(context).size.height * 39 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage(AppImage.markAttendeceCalenderImage))),
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(14),
                  dashPattern: [12, 12],
                  strokeWidth: 5,
                  color: Color(0xffEFEFEF),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 89 / 100,
                    height: MediaQuery.of(context).size.width * 40 / 100,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    22 /
                                    100,
                                height: MediaQuery.of(context).size.width *
                                    22 /
                                    100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      AppImage.imageUplouderIcon,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: Text(
                          AppLanguage.UploudPhotoText[language],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 12 / 100,
                ),
                DefaultButton(
                    text: AppLanguage.SubmitText[language],
                    onPress: () {
                      _showAlertDialog1(context);
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
