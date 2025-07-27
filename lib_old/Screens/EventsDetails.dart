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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsDetails extends StatefulWidget {
  static String routeName = './EventsDetails';

  const EventsDetails({Key? key}) : super(key: key);
  @override
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  _showAlertDialog1(BuildContext context) {
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  bool cancelButton = false;
  bool isLoading = true;
  List<dynamic> eventData = [];
  List<dynamic> availabilityDetails = [];
  String errorMessage = '';
  DateTime? initalDate;
  DateTime? selectedDate;
  String dateOfBirth = "MM/DD/YYYY";
  int? userId;
  List<dynamic> eventList = [];
  Set<DateTime> availableDates = {};

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(selectedDate);
    if (selectedDate == null) {
      dateOfBirth = "MM/DD/YYYY";
    }
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getUserData();
    if (userId != null) {
      await fetchMyEventData();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'User not logged in';
      });
    }
  }

  Future<void> fetchMyEventData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final url = Uri.parse('https://nadaindia.in/api/web/index.php?r=event/all-my-events&dco_user_id=${userId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          setState(() {
            eventData = jsonResponse['data']['event_list'] ?? [];
            availabilityDetails = jsonResponse['data']['availability_details'] ?? [];
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
    }
  }

  Future<void> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getInt('user_id');
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error accessing user data';
      });
    }
  }

  String _getDateRange(List<dynamic> availability) {
    if (availability.isEmpty) return 'No dates';

    final dates = availability.map((a) => DateTime.parse(a['availability_date'])).toList();
    dates.sort();

    DateTime? startDate;
    DateTime? endDate;
    List<String> dateRanges = [];

    for (int i = 0; i < dates.length; i++) {
      if (startDate == null) {
        startDate = dates[i];
        endDate = dates[i];
      } else if (dates[i].difference(endDate!).inDays == 1) {
        endDate = dates[i];
      } else {
        dateRanges.add(_formatDateRange(startDate, endDate));
        startDate = dates[i];
        endDate = dates[i];
      }
    }

    if (startDate != null) {
      dateRanges.add(_formatDateRange(startDate, endDate!));
    }

    return dateRanges.join(', ');
  }

  String _formatDateRange(DateTime start, DateTime end) {
    if (start == end) {
      return '${start.day}/${start.month}/${start.year}';
    } else {
      return '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
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
        title: Text(AppLanguage.ViewEventDetailsText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          child: Image.asset(AppImage.DownloadIcon),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black, style: BorderStyle.solid),
                                ),
                              ),
                              margin: EdgeInsets.only(left: 1),
                              child: Text(
                                AppLanguage.DeploymentApprovelText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Display each event's location and date range
                  ...availabilityDetails.map((event) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.53,
                    color: AppColor.greyBackgroundColor,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          color: AppColor.greyBackgroundColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.04,
                            vertical: 12,
                          ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(AppImage.locationIcon, color: Colors.black),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      event['location'] ?? 'NA',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.04,
                                      height: MediaQuery.of(context).size.width * 0.04,
                                      child: Image.asset(AppImage.calenderwhiteIcon, color: Colors.black),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                                    Text(
                                      _getDateRange(event['dco_availability']),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.98,
                          height: MediaQuery.of(context).size.width * 0.85,
                          color: Colors.white,
                          child: TableCalendar(
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: focusedDay,
                            calendarFormat: CalendarFormat.month,
                            selectedDayPredicate: (day) {
                              return isSameDay(selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                this.selectedDay = selectedDay;
                                this.focusedDay = focusedDay;
                              });
                            },
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle,
                              ),
                              defaultTextStyle: TextStyle(color: Colors.black),
                              weekendTextStyle: TextStyle(color: Colors.black),
                              todayTextStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: AppColor.themeColor,
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              rangeHighlightColor: AppColor.themeColor.withOpacity(0.3),
                              rangeStartDecoration: BoxDecoration(
                                color: AppColor.themeColor,
                                shape: BoxShape.circle,
                              ),
                              rangeEndDecoration: BoxDecoration(
                                color: AppColor.themeColor,
                                shape: BoxShape.circle,
                              ),
                              withinRangeTextStyle: TextStyle(color: Colors.black),
                              disabledTextStyle: TextStyle(color: Colors.grey),
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(color: Colors.black),
                            ),
                            availableGestures: AvailableGestures.all,
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(color: Colors.black),
                              weekendStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.023),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (!cancelButton) {
                                    _showAlertDialog1(context);
                                  }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.045,
                                  width: MediaQuery.of(context).size.width * 0.48,
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