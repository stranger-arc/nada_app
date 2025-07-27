import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/utilities/app_apis.dart';
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

class EventsDetails extends StatefulWidget {
  static String routeName = './EventsDetails';

  const EventsDetails({Key? key}) : super(key: key);

  @override
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  List<dynamic> availabilityDetails = [];
  bool isLoading = true;
  String errorMessage = '';
  Map<int, List<DateTime>> _selectedDates = {};
  Map<int, DateTime> _focusedDays = {};
  Map<int, bool> _isLoadingMap = {};
  int? userId;
  Map<int, List<DateTime>> _cancelledDates = {};

  @override
  void initState() {
    super.initState();
    _getUserData().then((_) {
      if (userId != null) {
        fetchAvailabilityData();
      }
    });
  }

  Future<void> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getInt('user_id');
      });
    } catch (e) {
      print('Error accessing SharedPreferences: $e');
    }
  }

  Future<void> fetchAvailabilityData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final url = Uri.parse(
        'https://nadaindia.in/api/web/index.php?r=event/all-my-events&dco_user_id=$userId',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          setState(() {
            availabilityDetails =
                jsonResponse['data']['availability_details'] ?? [];
            // Initialize selected dates and cancelled dates from availability data
            _selectedDates.clear();
            _cancelledDates.clear();
            print(availabilityDetails);
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

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> _cancelAvailability(int eventId) async {
    setState(() {
      _isLoadingMap[eventId] = true;
    });

    try {
      // Here we need to cancel the dates that were originally selected but now are NOT selected
      // (because the user tapped them to deselect)
      final originalDates = _selectedDates[eventId] ?? [];
      final List<DateTime> currentDates =
          []; // Explicitly type as List<DateTime>

      // Find the event matching the eventId
      final event = availabilityDetails.firstWhere(
        (e) => e['event_id'] == eventId,
        orElse: () => null,
      );

      if (event != null) {
        for (var avail in event['dco_availability']) {
          if (avail['cancellation_status'] == '0') {
            final date = DateTime.parse(avail['availability_date']);
            currentDates.add(date);
          }
        }
      }

      // The dates to cancel are the ones that were originally selected but are no longer in _selectedDates
      final datesToCancel =
          currentDates
              .where((date) => !originalDates.any((d) => isSameDay(d, date)))
              .toList();
      final formattedDates =
          datesToCancel
              .map((date) => DateFormat('yyyy-MM-dd').format(date))
              .toList();

      final url = Uri.parse(
        'https://nadaindia.in/api/web/index.php?r=event/cancel-availability',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "event_id": eventId,
          "dco_user_id": userId,
          "cancellation_details": [
            {"cancellation_dates": formattedDates},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          // Update the cancelled dates locally
          setState(() {
            _cancelledDates[eventId] ??= [];
            _cancelledDates[eventId]!.addAll(datesToCancel);
            // Remove the cancelled dates from selected dates
            _selectedDates[eventId]?.removeWhere(
              (date) => datesToCancel.any((d) => isSameDay(d, date)),
            );
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Availability cancelled successfully')),
          );
          // Refresh the data
          fetchAvailabilityData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                jsonResponse['message'] ?? 'Failed to cancel availability',
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to cancel availability: ${response.statusCode}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cancelling availability: $e')),
      );
    } finally {
      setState(() {
        _isLoadingMap[eventId] = false;
      });
    }
  }

  bool _isSelected(int eventId, DateTime day) {
    // A date is considered selected if it's in the _selectedDates map (meaning it's still booked)
    return _selectedDates[eventId]?.any((date) => isSameDay(date, day)) ??
        false;
  }

  void _onDaySelected(int eventId, DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDays[eventId] = focusedDay;
      _selectedDates[eventId] ??= [];

      // Toggle the selection - if it was selected (booked), deselect it (mark for cancellation)
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
          "Event Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                                  14 + MediaQuery.of(context).size.width * 0.04,
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

                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                if (!isLoading && errorMessage.isEmpty)
                  ...availabilityDetails.asMap().entries.map((entry) {
                    final event = entry.value;
                    final eventId = event['event_id'];
                    final startDate = DateTime.parse(event['event_start_date']);
                    final today = DateTime.now();
                    final todayDate = DateTime(
                      today.year,
                      today.month,
                      today.day,
                    );

                    final endDate = DateTime.parse(event['event_end_date']);
                    final focusedDay = _focusedDays[eventId] ?? startDate;
                    bool deploymentStatus = event['deployment_status'];
                    final apiDeployment = event['deployment_date'];
                    DateTime deploymentDate = startDate;
                    if (apiDeployment == null) {
                      deploymentDate = startDate;
                    } else {
                      try {
                        // First, check if the key exists AND its value is not null or empty
                        if (event.containsKey('deployment_date') &&
                            event['deployment_date'] != null &&
                            event['deployment_date'].toString().isNotEmpty) {
                          deploymentDate = DateTime.parse(
                            event['deployment_date'].toString(),
                          );
                        }
                      } catch (e) {
                        // If parsing fails (e.g., malformed string), checkDate remains null.
                        // You might want to log the error for debugging:
                        print(
                          'Error parsing availability_deadline_datetime: $e',
                        );
                        deploymentDate =
                            startDate; // Explicitly set to null on parsing error
                      }
                    }

                    final int confirmationTime =
                        event['disable_confirmation_in_day'];
                    final checkDate = deploymentDate.add(
                      Duration(days: confirmationTime),
                    );
                    // print('Deployment date: $deploymentDate');
                    // print('Check date: $checkDate');
                    // print('Today: $today');
                    final deploymentCheck =
                        event['dco_selectted_in_deployment'];
                    // Ensure focusedDay is within the valid range
                    final clampedFocusedDay =
                        focusedDay.isBefore(startDate)
                            ? startDate
                            : focusedDay.isAfter(endDate)
                            ? endDate
                            : focusedDay;
                    // Get the dates that are available but not selected (marked for cancellation)
                    final availableDates =
                        (event['dco_availability'] as List)
                            .where(
                              (avail) => avail['cancellation_status'] == '0',
                            )
                            .map(
                              (avail) =>
                                  DateTime.parse(avail['availability_date']),
                            )
                            .toList();

                    final datesForCancellation =
                        availableDates
                            .where(
                              (date) =>
                                  !_selectedDates[eventId]!.any(
                                    (d) => isSameDay(d, date),
                                  ),
                            )
                            .toList();

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 16),
                      color: AppColor.background,
                      child: Padding(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  14 + MediaQuery.of(context).size.width * 0.04,
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
                                    color: Color.fromARGB(255, 250, 255, 250),
                                    offset: Offset(-6, -6),
                                    // Slightly larger offset
                                    blurRadius: 15,
                                    // Increased blur for a softer, wider pop
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    // More prominent dark shadow
                                    // A darker, more distinct muted green for deeper contrast
                                    color: Color.fromARGB(255, 170, 180, 170),
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
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                        fontSize: 13,
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
                                                    color: Color(0xFFF1F8E9),
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
                                                              '${_formatDate(event['event_start_date'])} - ${_formatDate(event['event_end_date'])}',
                                                              style: TextStyle(
                                                                color: Color(
                                                                  0xFF296948,
                                                                ),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                    8,
                                                                  ),
                                                              child:
                                                                  (deploymentStatus ==
                                                                          false)
                                                                      ? (todayDate.isAfter(
                                                                            startDate,
                                                                          ))
                                                                          ? CircularLabel(
                                                                            //for event passed
                                                                            color:
                                                                                AppColor.error,
                                                                            radius:
                                                                                8.0,
                                                                          )
                                                                          : CircularLabel(
                                                                            //for deployment true
                                                                            color:
                                                                                AppColor.success,
                                                                            radius:
                                                                                8.0,
                                                                          )
                                                                      : CircularLabel(
                                                                        //for event open
                                                                        color:
                                                                            AppColor.warning,
                                                                        radius:
                                                                            8.0,
                                                                      ),
                                                            ),
                                                          ],
                                                        ),
                                                        if (checkDate.isBefore(
                                                          today,
                                                        ))
                                                          Text(
                                                            'Confirmation time has passed',
                                                            style: TextStyle(
                                                              color: Colors.red,
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
                                        //border: Border.all(color: Color(0xFF296948)),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 8),
                                          if (datesForCancellation.isNotEmpty)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4.0,
                                                  ),
                                              child: Text(
                                                'For Cancellation: ${datesForCancellation.map((date) => DateFormat('MMM dd').format(date)).join(', ')}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            //height: MediaQuery.of(context).size.width * 0.85,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.98,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: TableCalendar(
                                                firstDay: startDate,
                                                lastDay: endDate,
                                                focusedDay: clampedFocusedDay,
                                                selectedDayPredicate:
                                                    (day) => _isSelected(
                                                      eventId,
                                                      day,
                                                    ),
                                                onDaySelected:
                                                    (selectedDay, focusedDay) =>
                                                        _onDaySelected(
                                                          eventId,
                                                          selectedDay,
                                                          focusedDay,
                                                        ),
                                                enabledDayPredicate: (day) {
                                                  final isAvailable =
                                                      event['dco_availability'].any((
                                                        avail,
                                                      ) {
                                                        final availDate =
                                                            DateTime.parse(
                                                              avail['availability_date'],
                                                            );
                                                        return isSameDay(
                                                              availDate,
                                                              day,
                                                            ) &&
                                                            avail['cancellation_status'] ==
                                                                "0";
                                                      });
                                                  return isAvailable;
                                                },
                                                calendarStyle: CalendarStyle(
                                                  defaultTextStyle: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  weekendTextStyle: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  selectedTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  todayTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  todayDecoration:
                                                      BoxDecoration(
                                                        color:
                                                            Colors.blueAccent,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  selectedDecoration: BoxDecoration(
                                                    color: Colors.green
                                                        .withOpacity(0.3),
                                                    // Increased opacity for better visibility
                                                    shape: BoxShape.circle,
                                                  ),
                                                  withinRangeTextStyle:
                                                      TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                  disabledTextStyle: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  defaultDecoration:
                                                      BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                  outsideDecoration:
                                                      BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                  weekendDecoration:
                                                      BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: false,
                                                  titleCentered: true,
                                                  titleTextStyle: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                availableGestures:
                                                    AvailableGestures
                                                        .horizontalSwipe,
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                      weekdayStyle: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      weekendStyle: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                calendarBuilders: CalendarBuilders(
                                                  defaultBuilder: (
                                                    context,
                                                    day,
                                                    focusedDay,
                                                  ) {
                                                    final isToday = isSameDay(
                                                      day,
                                                      DateTime.now(),
                                                    );
                                                    final isAvailable =
                                                        event['dco_availability'].any((
                                                          avail,
                                                        ) {
                                                          final availDate =
                                                              DateTime.parse(
                                                                avail['availability_date'],
                                                              );
                                                          return isSameDay(
                                                                availDate,
                                                                day,
                                                              ) &&
                                                              avail['cancellation_status'] ==
                                                                  "0";
                                                        });
                                                    final isSelected =
                                                        _selectedDates[eventId]
                                                            ?.any(
                                                              (d) => isSameDay(
                                                                d,
                                                                day,
                                                              ),
                                                            ) ??
                                                        false;
                                                    final isCancelled =
                                                        event['dco_availability'].any((
                                                          avail,
                                                        ) {
                                                          final availDate =
                                                              DateTime.parse(
                                                                avail['availability_date'],
                                                              );
                                                          return isSameDay(
                                                                availDate,
                                                                day,
                                                              ) &&
                                                              avail['cancellation_status'] ==
                                                                  "1";
                                                        });

                                                    if (isCancelled) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 32,
                                                            height: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                        0.3,
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
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            'Cancelled',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .red[800],
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else if (isAvailable) {
                                                      // Handle selected dates (green) - priority over today
                                                      if (isSelected) {
                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 32,
                                                              height: 32,
                                                              decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green
                                                                    .withOpacity(
                                                                      0.3,
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
                                                                        Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'Booked',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .green[800],
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      // Handle today's date (blue)
                                                      else if (isToday) {
                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 32,
                                                              height: 32,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    Colors
                                                                        .blueAccent,
                                                                shape:
                                                                    BoxShape
                                                                        .circle,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${day.day}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'Today',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .blue[800],
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      // Regular available dates
                                                      else {
                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 32,
                                                              height: 32,
                                                              decoration: BoxDecoration(
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
                                                              child: Center(
                                                                child: Text(
                                                                  '${day.day}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'For Cancel',
                                                              style: TextStyle(
                                                                color:
                                                                    AppColor
                                                                        .themeColor,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    }

                                                    // For all other dates (not in API response)
                                                    return Center(
                                                      child: Container(
                                                        width: 32,
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              isToday
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : null,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${day.day}',
                                                            style: TextStyle(
                                                              color:
                                                                  isToday
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                              fontWeight:
                                                                  isToday
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  disabledBuilder: (
                                                    context,
                                                    day,
                                                    focusedDay,
                                                  ) {
                                                    final isToday = isSameDay(
                                                      day,
                                                      DateTime.now(),
                                                    );
                                                    final isCancelled =
                                                        event['dco_availability'].any((
                                                          avail,
                                                        ) {
                                                          final availDate =
                                                              DateTime.parse(
                                                                avail['availability_date'],
                                                              );
                                                          return isSameDay(
                                                                availDate,
                                                                day,
                                                              ) &&
                                                              avail['cancellation_status'] ==
                                                                  "1";
                                                        });

                                                    if (isCancelled) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 32,
                                                            height: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                        0.3,
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
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            'Cancelled',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .red[800],
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    return Center(
                                                      child: Container(
                                                        width: 32,
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              isToday
                                                                  ? Colors
                                                                      .lightBlueAccent
                                                                      .withOpacity(
                                                                        0.2,
                                                                      )
                                                                  : null,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${day.day}',
                                                            style: TextStyle(
                                                              color:
                                                                  isToday
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                              fontWeight:
                                                                  isToday
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                // Show cancel button only if there are dates marked for cancellation
                                                if (datesForCancellation
                                                        .isNotEmpty &&
                                                    (deploymentStatus ==
                                                        false) &&
                                                    todayDate.isBefore(
                                                      startDate,
                                                    ))
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await _cancelAvailability(
                                                        eventId,
                                                      );
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
                                                        color: Colors.red,
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
                                                                    .CancelAvilaibilityText[language],
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                    ),
                                                  ),
                                                if ((deploymentStatus ==
                                                        true) &&
                                                    (deploymentCheck == true))
                                                  (checkDate.isAfter(today) ||
                                                          checkDate
                                                              .isAtSameMomentAs(
                                                                today,
                                                              ))
                                                      ? GestureDetector(
                                                        onTap: () async {
                                                          await AppApis.confirmDeployment(
                                                            context: context,
                                                            dcoUserId: userId,
                                                            eventId: eventId,
                                                          );
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
                                                                    'Confirm',
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
                                                      )
                                                      : Container(
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
                                                          color:
                                                              Colors
                                                                  .grey
                                                                  .shade200,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                6,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          'Confirm',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
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
    );
  }
}
