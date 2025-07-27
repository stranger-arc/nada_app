import 'package:nada_dco/Screens/EventSubCategory.dart';
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

import '../widgets/circular_label.dart';

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
  Map<int, List<DateTime>> _selectedDates = {};
  Map<int, DateTime> _focusedDays = {};
  Map<int, bool> _isLoadingMap = {}; // Track loading state per event
  String dateOfBirth = "MM/DD/YYYY";
  int? userId;
  List<dynamic> availabilityDetails = [];
  Map<int, List<DateTime>> _cancelledDates = {};
  bool _isTapDisabled = false;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  void _onDaySelected(int eventId, DateTime selectedDay, DateTime focusedDay) {
    final availabilityEvent = availabilityDetails.firstWhere(
      (event) => event['event_id'] == eventId,
      orElse: () => null,
    );

    if (availabilityEvent != null) {
      final formattedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
      final availability = availabilityEvent['dco_availability'].firstWhere(
        (avail) =>
            avail['availability_date'] == formattedDay &&
            avail['status'] == '1' &&
            avail['cancellation_status'] == '0',
        orElse: () => null,
      );

      if (availability != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text('This date is already booked and cannot be modified'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    }

    setState(() {
      _focusedDays[eventId] = focusedDay;
      _selectedDates[eventId] ??= [];

      if (_selectedDates[eventId]!.any(
        (date) => isSameDay(date, selectedDay),
      )) {
        _selectedDates[eventId]!.removeWhere(
          (date) => isSameDay(date, selectedDay),
        );
      } else {
        _selectedDates[eventId]!.add(selectedDay);
      }
    });
  }

  bool _isSelected(int eventId, DateTime day) {
    return _selectedDates[eventId]?.any((date) => isSameDay(date, day)) ??
        false;
  }

  Future<void> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getInt('user_id');
      });
      print('User ID: $userId');
      fetchAvailabilityData();
    } catch (e) {
      print('Error accessing SharedPreferences: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEventData();
    _getUserData();
    _selectedDay = _focusedDay;
  }

  Future<void> fetchAvailabilityData() async {
    setState(() {
      isLoading = true;
      userId;
      errorMessage = '';
    });
    try {
      final url = Uri.parse(
        'https://nadaindia.in/api /web/index.php?r=event/all-my-events&dco_user_id=${userId}',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Print entire JSON response for debugging
        print('Full JSON response: $jsonResponse');
        print('api url full control: $url');

        if (jsonResponse['status'] == true) {
          setState(() {
            availabilityDetails =
                jsonResponse['data']['availability_details'] ?? [];

            // Also print availability details to see what you got
            print('Availability Details:');
            for (var event in availabilityDetails) {
              print(event);
            }

            // Initialize selected dates and cancelled dates from availability data
            _selectedDates.clear();
            _cancelledDates.clear();
            for (var event in availabilityDetails) {
              final eventId = event['event_id'];
              _selectedDates[eventId] = [];
              _cancelledDates[eventId] = [];

              // Initially, all available dates are considered "selected" (booked)
              for (var avail in event['dco_availability']) {
                final date = DateTime.parse(avail['availability_date']);
                if (avail['cancellation_status'] == '1') {
                  _cancelledDates[eventId]!.add(date);
                } else {
                  _selectedDates[eventId]!.add(date);
                }
              }

              // Ensure focusedDay is within the valid range
              final startDate = DateTime.parse(event['event_start_date']);
              final endDate = DateTime.parse(event['event_end_date']);
              final now = DateTime.now();

              // Set focusedDay to the first available day that's either today or after startDate
              DateTime initialFocusedDay =
                  now.isAfter(startDate) ? now : startDate;
              if (initialFocusedDay.isAfter(endDate)) {
                initialFocusedDay = endDate;
              }

              _focusedDays[eventId] = initialFocusedDay;
            }
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage =
                jsonResponse['message'] ?? 'Failed to load availability data';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Failed to load availability data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching availability data: $e';
      });
    }
  }

  Future<Map<String, dynamic>> markAvailability(
    int eventId,
    List<String> selectedDates,
  ) async {
    final body = {
      "event_id": eventId,
      "dco_user_id": userId,
      "marked_dates": selectedDates.map((date) => {"m_date": date}).toList(),
    };
    print("Request Body: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse(
          "https://nadaindia.in/api/web/index.php?r=event/mark-availability",
        ),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      bool status = data['status'] == true;
      String message =
          data['message'] ??
          (status ? 'Marked successfully!' : 'Failed to mark availability.');

      return {"status": status, "message": message};
    } catch (e) {
      return {"status": false, "message": 'Error occurred: $e'};
    }
  }

  Future<void> fetchEventData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final url = Uri.parse(
        'https://nadaindia.in/api/web/index.php?r=base/active-event-list',
      );
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
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        foregroundColor: AppColor.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Upcoming Events",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: AppColor.background,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    if (isLoading)
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      14 +
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                    color: Colors.white,
                                  ),
                                  width: double.infinity,
                                  height: 525,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                    // if (errorMessage.isNotEmpty)
                    //   Padding(
                    //     padding: EdgeInsets.all(20),
                    //     child: Text(
                    //       errorMessage,
                    //       style: TextStyle(color: Colors.red),
                    //     ),
                    //   ),
                    if (!isLoading)
                      ...eventData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final event = entry.value;
                        final eventId = event['id'];
                        final startDate = DateTime.parse(
                          eventData[index]['expected_start_datetime'],
                        );
                        final today = DateTime.now();
                        final todayDate = DateTime(
                          today.year,
                          today.month,
                          today.day,
                        );
                        final normalizedStartDate = DateTime(
                          startDate.year,
                          startDate.month,
                          startDate.day,
                        );
                        String apiDeadline =
                            eventData[index]['availability_deadline_datetime'];
                        DateTime? checkDate; // Make checkDate nullable
                        bool deploymentStatus =
                            eventData[index]['deployment_status'];
                        // Attempt to parse the deadline date.
                        // Use a try-catch block for robust parsing, as the string might be invalid or null.
                        if (apiDeadline == 'NA') {
                          checkDate = null;
                        } else {
                          try {
                            // First, check if the key exists AND its value is not null or empty
                            if (eventData[index].containsKey(
                                  'availability_deadline_datetime',
                                ) &&
                                eventData[index]['availability_deadline_datetime'] !=
                                    null &&
                                eventData[index]['availability_deadline_datetime']
                                    .toString()
                                    .isNotEmpty) {
                              checkDate = DateTime.parse(
                                eventData[index]['availability_deadline_datetime']
                                    .toString(),
                              );
                            }
                          } catch (e) {
                            // If parsing fails (e.g., malformed string), checkDate remains null.
                            // You might want to log the error for debugging:
                            print(
                              'Error parsing availability_deadline_datetime: $e',
                            );
                            checkDate =
                                null; // Explicitly set to null on parsing error
                          }
                        }
                        final Duration difference = normalizedStartDate
                            .difference(todayDate);
                        final isCalendarDisabled =
                            !normalizedStartDate.isAfter(todayDate);
                        late final bool isBookingDisabled;
                        if (deploymentStatus) {
                          isBookingDisabled = true;
                        } else {
                          if (checkDate == null ||
                              today.isAtSameMomentAs(checkDate) ||
                              today.isBefore(checkDate)) {
                            isBookingDisabled =
                                false; // No deadline, so booking is allowed
                          } else {
                            // checkDate is not null, so check if it's in the future
                            isBookingDisabled = checkDate.isBefore(todayDate);
                          }
                        }

                        return Container(
                          color: AppColor.background,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      14 +
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                    color: Color(0xFFDCEDC8),
                                    // border: Border(
                                    //   left: BoderSide(
                                    //     color: Colors.green,
                                    //     width: 3,
                                    //   ),
                                    // ),
                                    boxShadow: [
                                      BoxShadow(
                                        // More prominent light shadow
                                        // A very bright, almost white-green for a stronger highlight
                                        color: Color.fromARGB(
                                          255,
                                          250,
                                          255,
                                          250,
                                        ),
                                        offset: Offset(-6, -6),
                                        // Slightly larger offset
                                        blurRadius: 15,
                                        // Increased blur for a softer, wider pop
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        // More prominent dark shadow
                                        // A darker, more distinct muted green for deeper contrast
                                        color: Color.fromARGB(
                                          255,
                                          170,
                                          180,
                                          170,
                                        ),
                                        offset: Offset(6, 6),
                                        // Slightly larger offset
                                        blurRadius: 15,
                                        // Increased blur for a softer, wider pop
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                    child: Column(
                                      children: [
                                        //Removed event name
                                        /*SizedBox(
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
                                          ),*/
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(14),
                                                  topRight: Radius.circular(14),
                                                ),
                                                color: Color(0xFF296948),
                                                //border: Border.all(color: Colors.green,width: 2),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  5.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          AppImage.locationIcon,
                                                          width: 25,
                                                          height: 25,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          '${event['location']} (${event['state']})',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              9,
                                                            ),
                                                        color: Color(
                                                          0xFFF1F8E9,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              3.0,
                                                            ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  AppImage
                                                                      .calenderwhiteIcon,
                                                                  width: 25,
                                                                  height: 25,
                                                                  color: Color(
                                                                    0xFF296948,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${_formatDate(event['expected_start_datetime'])} - ${_formatDate(event['expected_end_datetime'])}',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF296948,
                                                                    ),
                                                                    fontSize:
                                                                        15,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                        8,
                                                                      ),
                                                                  child:
                                                                      (isBookingDisabled ==
                                                                              true)
                                                                          ? (deploymentStatus ==
                                                                                  true)
                                                                              ? CircularLabel(
                                                                                //for deployment true
                                                                                color:
                                                                                    AppColor.error,
                                                                                radius:
                                                                                    8.0,
                                                                              )
                                                                              : CircularLabel(
                                                                                //for deadline passed
                                                                                color:
                                                                                    AppColor.warning,
                                                                                radius:
                                                                                    8.0,
                                                                              )
                                                                          : CircularLabel(
                                                                            //for event open
                                                                            color:
                                                                                AppColor.success,
                                                                            radius:
                                                                                8.0,
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              //Is messy can fix later
                                                              event['availability_deadline_datetime'] ==
                                                                          null ||
                                                                      event['availability_deadline_datetime'] ==
                                                                          'NA' ||
                                                                      event['availability_deadline_datetime'] ==
                                                                          'N/A' ||
                                                                      event['availability_deadline_datetime']
                                                                              .toString()
                                                                              .trim()
                                                                              .toLowerCase() ==
                                                                          'na' ||
                                                                      event['availability_deadline_datetime']
                                                                          .toString()
                                                                          .isEmpty
                                                                  ? 'Last date to mark Availability is Not Available'
                                                                  : 'Last date to mark Availability is ${_formatDate(event['availability_deadline_datetime'])}',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12,
                                                                // fontWeight:
                                                                // FontWeight
                                                                //     .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(14),
                                              bottomRight: Radius.circular(14),
                                            ),
                                            color: Color(0xFFF1F8E9),
                                            // border: Border(
                                            //   left: BorderSide(
                                            //     color: Colors.green,
                                            //     width: 3,
                                            //   ),
                                            // ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 8),
                                              if (_selectedDates[index]
                                                      ?.isNotEmpty ??
                                                  false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                      ),
                                                  child: Text(
                                                    'Selected: ${_selectedDates[index]!.map((date) => DateFormat('MMM dd').format(date)).join(', ')}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (_isTapDisabled) return;
                                                  if (isCalendarDisabled) {
                                                    setState(() {
                                                      _isTapDisabled = true;
                                                    });

                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'This event is already Ongoing.',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.black,
                                                        duration: Duration(
                                                          seconds: 2,
                                                        ),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                      ),
                                                    );

                                                    Future.delayed(
                                                      Duration(seconds: 3),
                                                      () {
                                                        setState(() {
                                                          _isTapDisabled =
                                                              false;
                                                        });
                                                      },
                                                    );
                                                  } else if (isBookingDisabled) {
                                                    setState(() {
                                                      _isTapDisabled = true;
                                                    });

                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Event can\'t be booked anymore',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.red,
                                                        duration: Duration(
                                                          seconds: 2,
                                                        ),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                      ),
                                                    );

                                                    Future.delayed(
                                                      Duration(seconds: 3),
                                                      () {
                                                        setState(() {
                                                          _isTapDisabled =
                                                              false;
                                                        });
                                                      },
                                                    );
                                                    return;
                                                  }
                                                },
                                                child: SizedBox(
                                                  //height: MediaQuery.of(context).size.width * 0.85,
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.98,
                                                  child: AbsorbPointer(
                                                    // <-- Use AbsorbPointer here instead of IgnorePointer
                                                    absorbing:
                                                        isCalendarDisabled &&
                                                        isBookingDisabled,
                                                    child: TableCalendar(
                                                      firstDay: DateTime.utc(
                                                        2020,
                                                        12,
                                                        30,
                                                      ),
                                                      lastDay: DateTime.utc(
                                                        2030,
                                                        12,
                                                        31,
                                                      ),
                                                      focusedDay:
                                                          _focusedDays[index] ??
                                                          DateTime.now(),
                                                      selectedDayPredicate:
                                                          (day) => _isSelected(
                                                            index,
                                                            day,
                                                          ),
                                                      onDaySelected: (
                                                        selectedDay,
                                                        focusedDay,
                                                      ) {
                                                        final formattedDay =
                                                            DateFormat(
                                                              'yyyy-MM-dd',
                                                            ).format(
                                                              selectedDay,
                                                            );
                                                        final availabilityEvent =
                                                            availabilityDetails
                                                                .firstWhere(
                                                                  (event) =>
                                                                      event['event_id'] ==
                                                                      eventId,
                                                                  orElse:
                                                                      () =>
                                                                          null,
                                                                );

                                                        bool isBooked = false;
                                                        bool isCancelled =
                                                            false;

                                                        if (availabilityEvent !=
                                                            null) {
                                                          final availability =
                                                              availabilityEvent['dco_availability']
                                                                  .firstWhere(
                                                                    (avail) =>
                                                                        avail['availability_date'] ==
                                                                        formattedDay,
                                                                    orElse:
                                                                        () =>
                                                                            null,
                                                                  );

                                                          if (availability !=
                                                              null) {
                                                            isBooked =
                                                                availability['status'] ==
                                                                    '1' &&
                                                                availability['cancellation_status'] ==
                                                                    '0';
                                                            isCancelled =
                                                                availability['cancellation_status'] ==
                                                                '1';
                                                          }
                                                        }

                                                        if (isBooked) {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                "Date is already marked for Availability.",
                                                              ),
                                                              duration:
                                                                  Duration(
                                                                    seconds: 2,
                                                                  ),
                                                              backgroundColor:
                                                                  Colors
                                                                      .lightGreen,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                            ),
                                                          );
                                                          return;
                                                        }

                                                        if (isCancelled) {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                "This Date is Cancelled for Availability.",
                                                              ),
                                                              duration:
                                                                  Duration(
                                                                    seconds: 2,
                                                                  ),
                                                              backgroundColor:
                                                                  Colors
                                                                      .redAccent[700],
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                            ),
                                                          );
                                                          return;
                                                        }

                                                        // Proceed with selection
                                                        setState(() {
                                                          _selectedDay =
                                                              selectedDay;
                                                          _focusedDay =
                                                              focusedDay;
                                                          // _markedDates.add(selectedDay);
                                                        });
                                                        _onDaySelected(
                                                          index,
                                                          selectedDay,
                                                          focusedDay,
                                                        );
                                                      },

                                                      // onDaySelected: (selectedDay, focusedDay) =>
                                                      //     _onDaySelected(index, selectedDay, focusedDay),
                                                      enabledDayPredicate: (
                                                        day,
                                                      ) {
                                                        final today =
                                                            DateTime.now();
                                                        final todayDate =
                                                            DateTime(
                                                              today.year,
                                                              today.month,
                                                              today.day,
                                                            );
                                                        final startDate =
                                                            DateTime.parse(
                                                              eventData[index]['expected_start_datetime'],
                                                            );
                                                        final endDateRaw =
                                                            DateTime.parse(
                                                              eventData[index]['expected_end_datetime'],
                                                            );
                                                        final endDatePlusOne =
                                                            endDateRaw.add(
                                                              Duration(days: 1),
                                                            );
                                                        final effectiveStartDate =
                                                            startDate.isAfter(
                                                                  todayDate,
                                                                )
                                                                ? startDate
                                                                : todayDate;
                                                        return !day.isBefore(
                                                              effectiveStartDate,
                                                            ) &&
                                                            day.isBefore(
                                                              endDatePlusOne,
                                                            );
                                                      },
                                                      calendarStyle: CalendarStyle(
                                                        defaultTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        weekendTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        selectedTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        todayTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        todayDecoration:
                                                            BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .blueAccent,
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                        selectedDecoration:
                                                            BoxDecoration(
                                                              color: AppColor
                                                                  .themeColor
                                                                  .withOpacity(
                                                                    0.3,
                                                                  ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              border: Border.all(
                                                                color:
                                                                    AppColor
                                                                        .themeColor,
                                                                width: 2,
                                                              ),
                                                            ),
                                                        withinRangeTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        disabledTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                        defaultDecoration:
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                    0.1,
                                                                  ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                        outsideDecoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                        weekendDecoration:
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                    0.1,
                                                                  ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                      ),
                                                      headerStyle: HeaderStyle(
                                                        formatButtonVisible:
                                                            false,
                                                        titleCentered: true,
                                                        titleTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      availableGestures:
                                                          AvailableGestures.horizontalSwipe,
                                                      daysOfWeekStyle:
                                                          DaysOfWeekStyle(
                                                            weekdayStyle:
                                                                TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                            weekendStyle:
                                                                TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                          ),
                                                      calendarBuilders: CalendarBuilders(
                                                        selectedBuilder: (
                                                          context,
                                                          day,
                                                          focusedDay,
                                                        ) {
                                                          return Stack(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                child: Container(
                                                                  width: 36,
                                                                  height: 36,
                                                                  decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .themeColor
                                                                        .withOpacity(
                                                                          0.3,
                                                                        ),
                                                                    shape:
                                                                        BoxShape
                                                                            .circle,
                                                                    // border: Border.all(
                                                                    //   color: AppColor.themeColor,
                                                                    //   width: 2,
                                                                    // ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${day.day}',
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 45,
                                                                child: Text(
                                                                  'Selected',
                                                                  style: TextStyle(
                                                                    color:
                                                                        AppColor
                                                                            .themeColor,
                                                                    fontSize: 6,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                        todayBuilder: (
                                                          context,
                                                          day,
                                                          focusedDay,
                                                        ) {
                                                          return Stack(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                child: Container(
                                                                  width: 36,
                                                                  height: 36,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blueAccent
                                                                        .withOpacity(
                                                                          0.3,
                                                                        ),
                                                                    // Light opacity
                                                                    shape:
                                                                        BoxShape
                                                                            .circle,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${day.day}',
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 45,
                                                                child: Text(
                                                                  'Today',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .blueAccent,
                                                                    fontSize: 6,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                        defaultBuilder: (
                                                          context,
                                                          day,
                                                          focusedDay,
                                                        ) {
                                                          final today =
                                                              DateTime.now();
                                                          final currentDate =
                                                              DateTime(
                                                                today.year,
                                                                today.month,
                                                                today.day,
                                                              );
                                                          final todayDate =
                                                              DateTime(
                                                                today.year,
                                                                today.month,
                                                                today.day,
                                                              );
                                                          final startDate =
                                                              DateTime.parse(
                                                                eventData[index]['expected_start_datetime'],
                                                              );
                                                          final endDateRaw =
                                                              DateTime.parse(
                                                                eventData[index]['expected_end_datetime'],
                                                              );
                                                          final endDatePlusOne =
                                                              endDateRaw.add(
                                                                Duration(
                                                                  days: 1,
                                                                ),
                                                              );
                                                          final isEnabled =
                                                              !day.isBefore(
                                                                todayDate,
                                                              ) &&
                                                              day.isBefore(
                                                                endDatePlusOne,
                                                              );
                                                          final isExpiredPeriod =
                                                              !day.isBefore(
                                                                startDate,
                                                              ) &&
                                                              day.isBefore(
                                                                todayDate,
                                                              );
                                                          final normalizedStartDate =
                                                              DateTime(
                                                                startDate.year,
                                                                startDate.month,
                                                                startDate.day,
                                                              );
                                                          final isOngoing =
                                                              (currentDate.isAfter(
                                                                    normalizedStartDate,
                                                                  ) ||
                                                                  isSameDay(
                                                                    currentDate,
                                                                    normalizedStartDate,
                                                                  )) &&
                                                              (currentDate
                                                                      .isBefore(
                                                                        endDateRaw,
                                                                      ) ||
                                                                  isSameDay(
                                                                    currentDate,
                                                                    endDateRaw,
                                                                  ));
                                                          bool isBooked = false;
                                                          bool isCancelled =
                                                              false;

                                                          final availabilityEvent =
                                                              availabilityDetails
                                                                  .firstWhere(
                                                                    (event) =>
                                                                        event['event_id'] ==
                                                                        eventId,
                                                                    orElse:
                                                                        () =>
                                                                            null,
                                                                  );

                                                          if (availabilityEvent !=
                                                              null) {
                                                            final formattedDay =
                                                                DateFormat(
                                                                  'yyyy-MM-dd',
                                                                ).format(day);
                                                            final availability =
                                                                availabilityEvent['dco_availability']
                                                                    .firstWhere(
                                                                      (avail) =>
                                                                          avail['availability_date'] ==
                                                                          formattedDay,
                                                                      orElse:
                                                                          () =>
                                                                              null,
                                                                    );

                                                            if (availability !=
                                                                null) {
                                                              isBooked =
                                                                  availability['status'] ==
                                                                      '1' &&
                                                                  availability['cancellation_status'] ==
                                                                      '0';
                                                              isCancelled =
                                                                  availability['cancellation_status'] ==
                                                                  '1';
                                                            }
                                                          }

                                                          if (isCancelled) {
                                                            return IgnorePointer(
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Center(
                                                                    child: Container(
                                                                      width: 32,
                                                                      height:
                                                                          32,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .orange
                                                                            .withOpacity(
                                                                              0.18,
                                                                            ),
                                                                        shape:
                                                                            BoxShape.circle,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '${day.day}',
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 45,
                                                                    child: Text(
                                                                      'Cancelled',
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.orange[800],
                                                                        fontSize:
                                                                            6,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else if (isBooked) {
                                                            return IgnorePointer(
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Center(
                                                                    child: Container(
                                                                      width: 32,
                                                                      height:
                                                                          32,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .lightGreen
                                                                            .withOpacity(
                                                                              0.3,
                                                                            ),
                                                                        shape:
                                                                            BoxShape.circle,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '${day.day}',
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 45,
                                                                    child: Text(
                                                                      'Booked',
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.lightGreen,
                                                                        fontSize:
                                                                            6,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else if (isOngoing) {
                                                            return Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    width: 32,
                                                                    height: 32,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                            0.2,
                                                                          ),
                                                                      shape:
                                                                          BoxShape
                                                                              .circle,
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        '${day.day}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              isSameDay(
                                                                                    day,
                                                                                    todayDate,
                                                                                  )
                                                                                  ? FontWeight.bold
                                                                                  : FontWeight.normal,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 45,
                                                                  child: Text(
                                                                    'Ongoing',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .grey[800],
                                                                      fontSize:
                                                                          6,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          } else if (isEnabled) {
                                                            return Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    width: 32,
                                                                    height: 32,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green
                                                                          .withOpacity(
                                                                            0.18,
                                                                          ),
                                                                      shape:
                                                                          BoxShape
                                                                              .circle,
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        '${day.day}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 45,
                                                                  child: Text(
                                                                    'Available',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .green[800],
                                                                      fontSize:
                                                                          6,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          } else if (isExpiredPeriod) {
                                                            return Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    width: 32,
                                                                    height: 32,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                            0.18,
                                                                          ),
                                                                      shape:
                                                                          BoxShape
                                                                              .circle,
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        '${day.day}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 45,
                                                                  child: Text(
                                                                    'Expired',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .red[800],
                                                                      fontSize:
                                                                          6,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          return Center(
                                                            child: Text(
                                                              '${day.day}',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        disabledBuilder: (
                                                          context,
                                                          day,
                                                          focusedDay,
                                                        ) {
                                                          final startDate =
                                                              DateTime.parse(
                                                                eventData[index]['expected_start_datetime'],
                                                              );
                                                          final today =
                                                              DateTime.now();
                                                          final todayDate =
                                                              DateTime(
                                                                today.year,
                                                                today.month,
                                                                today.day,
                                                              );
                                                          final isExpiredPeriod =
                                                              !day.isBefore(
                                                                startDate,
                                                              ) &&
                                                              day.isBefore(
                                                                todayDate,
                                                              );
                                                          if (isExpiredPeriod) {
                                                            return Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    width: 32,
                                                                    height: 32,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                            0.18,
                                                                          ),
                                                                      shape:
                                                                          BoxShape
                                                                              .circle,
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        '${day.day}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 45,
                                                                  child: Text(
                                                                    'Expired',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .red[800],
                                                                      fontSize:
                                                                          6,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          return Center(
                                                            child: Text(
                                                              '${day.day}',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              if (isBookingDisabled == false)
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          if (_selectedDates[index]
                                                                  ?.isNotEmpty ??
                                                              false) {
                                                            List<String>
                                                            selectedDates =
                                                                _selectedDates[index]!
                                                                    .map(
                                                                      (
                                                                        date,
                                                                      ) => DateFormat(
                                                                        'yyyy-MM-dd',
                                                                      ).format(
                                                                        date,
                                                                      ),
                                                                    )
                                                                    .toList();

                                                            setState(() {
                                                              _isLoadingMap[eventId] =
                                                                  true;
                                                            });

                                                            final result =
                                                                await markAvailability(
                                                                  eventId,
                                                                  selectedDates,
                                                                );

                                                            setState(() {
                                                              _isLoadingMap[eventId] =
                                                                  false;
                                                            });

                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Availability marked Successfully.',
                                                                ),
                                                                duration:
                                                                    Duration(
                                                                      seconds:
                                                                          2,
                                                                    ),
                                                                backgroundColor:
                                                                    result['status']
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .green,
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                              ),
                                                            );
                                                          } else {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Please select at least one date.',
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                duration:
                                                                    Duration(
                                                                      seconds:
                                                                          2,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          height:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.height *
                                                              0.045,
                                                          width:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.width *
                                                              0.48,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              0xFF9CCC65,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  6,
                                                                ),
                                                          ),
                                                          child:
                                                              (_isLoadingMap[eventId] ??
                                                                      false)
                                                                  ? SizedBox(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child: CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  )
                                                                  : Text(
                                                                    AppLanguage
                                                                        .MarkAvilaibilityText[language],
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
