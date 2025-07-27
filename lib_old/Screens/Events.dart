import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/material.dart';
import '../utilities/app_constant.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<dynamic> eventData = [];
  bool isLoading = true;
  String errorMessage = '';
  bool showCalendar = false;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _fromDate;
  DateTime? _toDate;
  Map<int, DateTime?> _fromDates = {};
  Map<int, DateTime?> _toDates = {};
  Map<int, DateTime> _focusedDays = {};
  bool _isLoading = false;
  String dateOfBirth = "MM/DD/YYYY";
  String? firstName;
  String? username;
  String? email;
  String? lastName;
  int? active;
  int? userId;
  int? userTypeId;

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

  void _onDaySelected(int eventId, DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_fromDates[eventId] == null || (_fromDates[eventId] != null && _toDates[eventId] != null)) {
        _fromDates[eventId] = selectedDay;
        _toDates[eventId] = null;
      } else if (_fromDates[eventId] != null && _toDates[eventId] == null) {
        if (selectedDay.isAfter(_fromDates[eventId]!)) {
          _toDates[eventId] = selectedDay;
        } else {
          _fromDates[eventId] = selectedDay;
        }
      }
      _focusedDays[eventId] = focusedDay;
    });
  }

  bool _isWithinRange(int eventId, DateTime day) {
    if (_fromDates[eventId] != null && _toDates[eventId] != null) {
      return day.isAfter(_fromDates[eventId]!) && day.isBefore(_toDates[eventId]!);
    }
    return false;
  }
  @override
  void initState() {
    super.initState();
    fetchEventData();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        firstName = prefs.getString('first_name');
        username = prefs.getString('username');
        email = prefs.getString('email');
        lastName = prefs.getString('last_name');
        active = prefs.getInt('active');
        userId = prefs.getInt('user_id');
        userTypeId = prefs.getInt('user_type_id');
      });
      print('User Data Loaded:');
      print('First Name: $firstName');
      print('Username: $username');
      print('Email: $email');
      print('Last Name: $lastName');
      print('Active: $active');
      print('User ID: $userId');
      print('User Type ID: $userTypeId');
    } catch (e) {
      print('Error accessing SharedPreferences: $e');
    }
  }

  Future<Map<String, dynamic>> markAvailability(int eventId, List<String> selectedDates) async {
    final body = {
      "event_id": eventId,
      "dco_user_id": userId,
      "marked_dates": selectedDates.map((date) => {"m_date": date}).toList(),
    };
    print("Request Body: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse("https://nadaindia.in/api/web/index.php?r=event/mark-availability"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      // Ensure status is strictly false or true
      bool status = data['status'] == true;
      String message = data['message'] ?? (status ? 'Marked successfully!' : 'Failed to mark availability.');

      return {"status": status, "message": message};
    } catch (e) {
      return {"status": false, "message": 'Error occurred: $e'};
    }
  }

  List<String> getDateRange(DateTime start, DateTime end) {
    List<String> dates = [];
    for (DateTime date = start;
    !date.isAfter(end);
    date = date.add(Duration(days: 1))) {
      dates.add(DateFormat('yyyy-MM-dd').format(date));
    }
    return dates;
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

                  if (isLoading)
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,       // already light
                        highlightColor: Colors.grey.shade50,   // even lighter
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Container(
                                width: double.infinity,
                                height: 525,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                      ),
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
                    ...eventData.asMap().entries.map((entry) {
                      final index = entry.key; // Using index as unique identifier
                      final event = entry.value;
                      return Container(
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
                                            event['location'] ?? 'No location found',
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
                                mainAxisSize: MainAxisSize.min,
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
                                  // Show From and To Dates
                                  if (_fromDates[index] != null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Text(
                                        'From: ${DateFormat('yyyy-MM-dd').format(_fromDates[index]!)}'
                                            '${_toDates[index] != null ? '  To: ${DateFormat('yyyy-MM-dd').format(_toDates[index]!)}' : ''}',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  Container(
                                    height: MediaQuery.of(context).size.width * 0.85,
                                    width: MediaQuery.of(context).size.width * 0.98,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: TableCalendar(
                                        firstDay: DateTime.now(),
                                        lastDay: DateTime.utc(2030, 12, 31),
                                        focusedDay: _focusedDays[index] ?? DateTime.now(),
                                        selectedDayPredicate: (day) =>
                                        isSameDay(_fromDates[index], day) ||
                                            isSameDay(_toDates[index], day) ||
                                            _isWithinRange(index, day),
                                        onDaySelected: (selectedDay, focusedDay) =>
                                            _onDaySelected(index, selectedDay, focusedDay),
                                        enabledDayPredicate: (day) {
                                          final today = DateTime.now();
                                          final todayDate = DateTime(today.year, today.month, today.day);
                                          final startDate = DateTime.parse(eventData[index]['expected_start_datetime']);
                                          final endDateRaw = DateTime.parse(eventData[index]['expected_end_datetime']);
                                          final endDatePlusOne = endDateRaw.add(Duration(days: 1));
                                          final effectiveStartDate = startDate.isAfter(todayDate) ? startDate : todayDate;
                                          return !day.isBefore(effectiveStartDate) && day.isBefore(endDatePlusOne);
                                        },
                                        calendarStyle: CalendarStyle(
                                          defaultTextStyle: TextStyle(color: Colors.black),
                                          weekendTextStyle: TextStyle(color: Colors.black),
                                          selectedTextStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          todayTextStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          todayDecoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            shape: BoxShape.circle,
                                          ),
                                          selectedDecoration: BoxDecoration(
                                            color: AppColor.themeColor,
                                            shape: BoxShape.circle,
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
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (_fromDates[index] != null) {
                                              DateTime from = _fromDates[index]!;
                                              DateTime to = _toDates[index] ?? from;

                                              List<String> selectedDates = getDateRange(from, to);
                                              int eventId = eventData[index]['id'];

                                              setState(() {
                                                _isLoading = true;
                                              });

                                              final result = await markAvailability(eventId, selectedDates);

                                              setState(() {
                                                _isLoading = false;
                                              });

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(result['message']),
                                                  backgroundColor: result['status'] ? Colors.green : Colors.red,
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Please select a date first.'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
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
                                            child: _isLoading
                                                ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                                : Text(
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
                            )
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}