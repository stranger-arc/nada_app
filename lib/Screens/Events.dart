import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/material.dart';
import '../utilities/app_constant.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool calender1 = false;
  bool calender2 = false;
  List<dynamic> eventData = [];
  bool isLoading = true;
  String errorMessage = '';

  void _showAlertDialog1(BuildContext context) {
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
            message: AppLanguage.EventCongretulationText[language],
            title: AppLanguage.SuccessText[language],
            screenName: "eventscreen",
          ),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(AppLanguage.EventModelText[language]),
      actions: [cancelButton, continueButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  Future<void> fetchEventData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final url = Uri.parse('https://nadaindia.in/api/web/index.php?r=base/active-event-list');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          setState(() {
            eventData = jsonResponse['data']['event_list'] ?? [];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = jsonResponse['message'] ?? 'Failed to load events';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load events: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching events: $e';
      });
      print('Error fetching events: $e');
    }
  }

  String _getCurrentMonth() {
    final now = DateTime.now();
    return DateFormat('MMMM').format(now);
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
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
        leading: IconButton(
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
        ),
        title: Text(
          AppLanguage.EventsText[language],
          style: Constant.appBarCenterTitleStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Loading state
                  if (isLoading)
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),

                  // Error state
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                  // Event List Section
                  if (!isLoading && errorMessage.isEmpty)
                    ...eventData.map((event) => Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          // Upper Section: Grey Background
                          Container(
                            color: AppColor.greyBackgroundColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.04,
                              vertical: 12,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.92,
                                  child: Text(
                                    event['name'] ?? 'No event name',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppFont.fontFamily,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImage.locationIcon,
                                          width: 20,
                                          height: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          AppLanguage.NethajiIndoorStadiumText[language],
                                          // event['location'] ?? 'No location found',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImage.calenderwhiteIcon,
                                          width: 20,
                                          height: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${_formatDate(event['expected_start_datetime'])} - ${_formatDate(event['expected_end_datetime'])}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Calendar Section: White Background
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    _getCurrentMonth(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      calender1 = !calender1;
                                    });
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.53,
                                    width: MediaQuery.of(context).size.width * (calender1 ? 0.97 : 0.98),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          calender1 ? AppImage.calenderImage1 : AppImage.calenderImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.003),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (calender1) {
                                            _showAlertDialog1(context);
                                          }
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.045,
                                          width: MediaQuery.of(context).size.width * 0.48,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColor.themeColor,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            AppLanguage.MarkAvilaibilityText[language],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
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
                    )).toList(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}