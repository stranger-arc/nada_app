import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/Screens/TravelSubCategory.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/default_button.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class TravelPlans extends StatefulWidget {
  static String routeName = './TravelPlans';

  const TravelPlans({Key? key}) : super(key: key);

  @override
  _TravelPlansState createState() => _TravelPlansState();
}

class _TravelPlansState extends State<TravelPlans> {
  bool toggleButton = true;
  bool toggleButtonsecound = true;
  bool tab1 = true;
  bool tab2 = false;
  bool Select1 = true;
  bool Select2 = false;
  bool Select3 = false;
  bool var1 = true;
  bool var2 = false;
  bool var3 = false;
  DateTime? initalDate;
  DateTime? selectedDate;
  String dateOfBirth = "Departure Date";
  DateTime? initalDate1;
  DateTime? selectedDate1;
  String dateOfBirth1 = "Departure Date";

  String transportofmode = "Road";

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

  void initState() {
    super.initState();
    print(selectedDate);
    if (selectedDate == null) {
      dateOfBirth = "Departure Date";
    }
    if (selectedDate1 == null) {
      dateOfBirth = "Departure Date";
    }
  }

  @override
  void dispose() {
    super.dispose();
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
        Navigator.pushNamed(
          context,
          SuccessScreen.routeName,
          arguments: SuccessClass(
            message: AppLanguage.TicketSuccessText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "travelplanscreen",
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(AppLanguage.TicketDetailsModelText[language]),
      actions: [cancelButton, continueButton],
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
              icon: Image.asset(AppImage.backicon, height: 25, width: 25),
              onPressed: () {
                Navigator.pushNamed(context, TravelSubCategory.routeName);
              },
            ),
          ),
          title: Text(
            AppLanguage.TravelPlanText[language],
            style: Constant.appBarCenterTitleStyle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              color: Colors.white,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showListBottomSheet(
                        context,
                        "Select Event",
                        eventList,
                        1,
                        true,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 88 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // toggleButton = !toggleButton;
                              tab1 = true;
                              tab2 = false;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 6 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 6 / 100,
                                child: Image.asset(
                                  tab1 == false
                                      ? AppImage.deactivateRadioIcon
                                      : AppImage.activateRadioIcon,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                AppLanguage.SingleTripTicketText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tab1 = false;
                              tab2 = true;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    6.0 /
                                    100,
                                height:
                                    MediaQuery.of(context).size.width *
                                    6.0 /
                                    100,
                                child: Image.asset(
                                  tab2 == false
                                      ? AppImage.deactivateRadioIcon
                                      : AppImage.activateRadioIcon,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                AppLanguage.RoundTripText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),

                  GestureDetector(
                    onTap: () {
                      _showDatePicker(1, 1);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        dateOfBirth.toString(),
                                        style: Constant.textFilledStyle,
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
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
                            margin: EdgeInsets.only(top: 6),
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
                    height: MediaQuery.of(context).size.height * 2.5 / 100,
                  ),

                  GestureDetector(
                    onTap: () {
                      _showListBottomSheet(
                        context,
                        "Select City",
                        cities,
                        2,
                        true,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguage.SelectFromCityText[language],
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
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
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
                    height: MediaQuery.of(context).size.height * 2.5 / 100,
                  ),

                  GestureDetector(
                    onTap: () {
                      _showListBottomSheet(
                        context,
                        AppLanguage.SelectCityText[language],
                        cities,
                        2,
                        true,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguage.SelectToCityText[language],
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
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
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
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  Container(
                    // padding: EdgeInsets.only(top:5),
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    height: MediaQuery.of(context).size.height * 6.5 / 100,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child: Text(
                                AppLanguage.INRText[language],
                                style: Constant.textFilledStyle,
                              ),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.2 / 100,
                              height:
                                  MediaQuery.of(context).size.height *
                                  3.3 /
                                  100,
                              color: Colors.grey,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 78 / 100,
                              // height: MediaQuery.of(context).size.height * 6 / 100,
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 50,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    counterText: '',
                                    hintText: 'Fare',
                                    hintStyle: Constant.textFilledStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          width: MediaQuery.of(context).size.width * 88 / 100,
                          height:
                              MediaQuery.of(context).size.height * 0.1 / 100,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 88 / 100,
                    child: Text(
                      AppLanguage.ModeofTransportText[language],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 89 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // toggleButton
                              // = !toggleButton;
                              transportofmode = "Road";
                              Select1 = true;
                              Select2 = false;
                              Select3 = false;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 6 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 6 / 100,
                                child: Image.asset(
                                  Select1 == false
                                      ? AppImage.deactivateRadioIcon
                                      : AppImage.activateRadioIcon,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                AppLanguage.RoadText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              transportofmode = "Train";
                              Select1 = false;
                              Select2 = true;
                              Select3 = false;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    6.0 /
                                    100,
                                height:
                                    MediaQuery.of(context).size.width *
                                    6.0 /
                                    100,
                                child: Image.asset(
                                  Select2 == false
                                      ? AppImage.deactivateRadioIcon
                                      : AppImage.activateRadioIcon,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                AppLanguage.TrainText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              transportofmode = "Airlines";
                              Select1 = false;
                              Select2 = false;
                              Select3 = true;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    6.0 /
                                    100,
                                height:
                                    MediaQuery.of(context).size.width *
                                    6.0 /
                                    100,
                                child: Image.asset(
                                  Select3 == false
                                      ? AppImage.deactivateRadioIcon
                                      : AppImage.activateRadioIcon,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                AppLanguage.AirlinesText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    child: Text(
                      AppLanguage.UploadScanCopyofTicketText[language],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2.5 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 88 / 100,
                    height: MediaQuery.of(context).size.width * 40 / 100,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(
                            0,
                            1,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: Radius.circular(14),
                        dashPattern: [12, 12],
                        strokeWidth: 5,
                        color: Color(0xffEFEFEF),),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.width * 50 / 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 22 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 22 / 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImage.imageUplouderIcon),
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 88 / 100,
                              child: Text(
                                AppLanguage
                                    .UploadScanCopyofTicketText[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    color: Color(0xffEFEFEF),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2.3 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 88 / 100,
                    child: Text(
                      tab1 == true
                          ? AppLanguage.ReturnDetailsOptionalText[language]
                          : AppLanguage.ReturnDetailsText[language],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width * 88 / 100,
                  //     child: Text(
                  //       AppLanguage.DepartureDateText[language],
                  //       style: const TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 15),
                  //     )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDatePicker1();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                // height: MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        dateOfBirth1.toString(),
                                        style: Constant.textFilledStyle,
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
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
                            margin: EdgeInsets.only(top: 6),
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
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width * 88 / 100,
                  //     child: Text(
                  //       AppLanguage.FromText[language],
                  //       style: const TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 15),
                  //     )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showListBottomSheet(
                        context,
                        AppLanguage.SelectCityText[language],
                        cities,
                        2,
                        true,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguage.SelectFromCityText[language],
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
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
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
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width * 88 / 100,
                  //     child: Text(
                  //       AppLanguage.ToText[language],
                  //       style: const TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 15),
                  //     )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showListBottomSheet(
                        context,
                        AppLanguage.SelectCityText[language],
                        cities,
                        2,
                        true,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                    86 /
                                    100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6 / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguage.SelectToCityText[language],
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
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
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
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width * 90 / 100,
                  //     child: Text(
                  //       AppLanguage.FareText[language],
                  //       style: const TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 15),
                  //     )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 / 100,
                  ),
                  Container(
                    // padding: EdgeInsets.only(top:5),
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    height: MediaQuery.of(context).size.height * 6.5 / 100,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              child: Text(
                                AppLanguage.INRText[language],
                                style: Constant.textFilledStyle,
                              ),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 2 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.2 / 100,
                              height:
                                  MediaQuery.of(context).size.height *
                                  3.3 /
                                  100,
                              color: Colors.grey,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 78 / 100,
                              // height: MediaQuery.of(context).size.height * 6 / 100,
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 50,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    counterText: '',
                                    hintText: '2300',
                                    hintStyle: Constant.textFilledStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1.5),
                          width: MediaQuery.of(context).size.width * 88 / 100,
                          height:
                              MediaQuery.of(context).size.height * 0.1 / 100,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100,
                  ),
                  tab1 == true
                      ? Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            child: Text(
                              AppLanguage.ModeofTransportText[language],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      var1 = true;
                                      var2 = false;
                                      var3 = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            6 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.width *
                                            6 /
                                            100,
                                        child: Image.asset(
                                          var1 == false
                                              ? AppImage.deactivateRadioIcon
                                              : AppImage.activateRadioIcon,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        AppLanguage.RoadText[language],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      var1 = false;
                                      var2 = true;
                                      var3 = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            6.0 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.width *
                                            6.0 /
                                            100,
                                        child: Image.asset(
                                          var2 == false
                                              ? AppImage.deactivateRadioIcon
                                              : AppImage.activateRadioIcon,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        AppLanguage.TrainText[language],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      var1 = false;
                                      var2 = false;
                                      var3 = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            6.0 /
                                            100,
                                        height:
                                            MediaQuery.of(context).size.width *
                                            6.0 /
                                            100,
                                        child: Image.asset(
                                          var3 == false
                                              ? AppImage.deactivateRadioIcon
                                              : AppImage.activateRadioIcon,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        AppLanguage.AirlinesText[language],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            child: Text(
                              AppLanguage.ModeofTransportText[language],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            child: Text(
                              transportofmode.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 88 / 100,
                    child: Text(
                      AppLanguage.UploadScanCopyofTicketText[language],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(
                            0,
                            1,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: Radius.circular(14),
                        dashPattern: [12, 12],
                        strokeWidth: 5,
                        color: Color(0xffEFEFEF),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.width * 40 / 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 22 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 22 / 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImage.imageUplouderIcon),
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: Text(
                                AppLanguage
                                    .UploadScanCopyofTicketText[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                  ),
                  DefaultButton(
                    text: AppLanguage.SubmitText[language],
                    onPress: () {
                      _showAlertDialog1(context);
                      //    Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Login(title: "")),
                      // );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showListBottomSheet(
    BuildContext context,
    String title,
    List dataList,
    type,
    bool status,
  ) {
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
                  top: MediaQuery.of(context).size.width * 12 / 100,
                ),
                height: MediaQuery.of(context).size.height,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    title: Text(
                      title.toString(),
                      style: Constant.appBarCenterTitleStyle,
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
                          ? Container(
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            height:
                                MediaQuery.of(context).size.height * 6.5 / 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                    0,
                                    1,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width *
                                        6 /
                                        100,
                                    height:
                                        MediaQuery.of(context).size.width *
                                        6 /
                                        100,
                                    child: Image.asset(AppImage.searchIcon),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        75 /
                                        100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      keyboardType: TextInputType.name,
                                      maxLength: 50,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        counterText: '',
                                        hintText:
                                            AppLanguage.SearchText[language],
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                left: 12,
                                bottom: 70,
                              ),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: dataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      var data = dataList;
                                      for (int i = 0; i < data.length; i++) {
                                        data[i]['status'] = false;
                                      }
                                      data[index]['status'] = true;

                                      //   eventList = data;
                                      //   if (type == 1) {
                                      //     states = data;
                                      //    } else if (type == 2) {
                                      //   //   cities = data;
                                      //  } else if (type == 3) {
                                      //      employeeTypeList = data;
                                      //    }
                                      setState(() {});
                                    },
                                    child: CustomRow(
                                      title: dataList[index]['title'],
                                      status: dataList[index]['status'],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 25),
                                child: DefaultButton(
                                  text: AppLanguage.ContinueText[language],
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showDatePicker(index, type) async {
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
                      dateOfBirth = "Departure Date";
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                    child: Text(
                      AppLanguage.DoneText[language],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: () {
                      if (selectedDate != null) {
                        initalDate = selectedDate;
                        String date = DateFormat(
                          'MM/dd/yyyy',
                        ).format(selectedDate!);
                        dateOfBirth = date;
                        print(date);
                      }
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ],
              ),
              const Divider(height: 0, thickness: 1),
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

  Future<void> _showDatePicker1() async {
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
                      selectedDate1 = null;
                      dateOfBirth1 = "Departure Date";
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
                        initalDate1 = selectedDate1;
                        String date = DateFormat(
                          'MM/dd/yyyy',
                        ).format(selectedDate1!);
                        dateOfBirth1 = date;
                        print(date);
                      }
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ],
              ),
              const Divider(height: 0, thickness: 1),
              Expanded(
                child: CupertinoDatePicker(
                  maximumDate: initalDate1,
                  initialDateTime: initalDate1,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime dateTime) {
                    selectedDate1 = dateTime;
                    print("selectedDate $selectedDate1");
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
}
