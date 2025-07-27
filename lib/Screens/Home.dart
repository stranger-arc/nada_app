import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:nada_dco/Screens/EducationAwareness.dart';
import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/Screens/IdCardDetails.dart';
import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/LogisticsSubCategory.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/Profile.dart';
import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/SampleCollectionSubCategory.dart';
import 'package:nada_dco/Screens/SampleDepositeSubCategory.dart';
import 'package:nada_dco/Screens/TravelSubCategory.dart';
import 'package:nada_dco/Screens/AttendanceSubCategory.dart';
import 'package:nada_dco/common/bottom_nav.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_theme.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:nada_dco/utilities/page_transitions.dart';
import 'package:nada_dco/widgets/auto_typing_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Settings.dart';

class Home extends StatefulWidget {
  final String? userId;

  const Home({Key? key, this.userId}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email = '';
  String fname = '';
  String lname = '';
  List<dynamic> availabilityDetails = [];
  late int bookedEvents;

  Map<String, dynamic>? nearestEvent;
  int? userId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }



  List<Eventlist> event = [
    Eventlist(
      name: AppLanguage.TravelPlanText[language],
      image: AppImage.TravelIcon,
    ),
    Eventlist(
      name: AppLanguage.LogisticsText[language],
      image: AppImage.LogisticsIcon,
    ),
    Eventlist(
      name: AppLanguage.AttendanceText[language],
      image: AppImage.AttendanceIcon,
    ),
    Eventlist(
      name: AppLanguage.SampleCollectionText[language],
      image: AppImage.SampcollectionIcon,
    ),
    Eventlist(
      name: AppLanguage.SampleDepositeText[language],
      image: AppImage.SampledepositIcon,
    ),
    Eventlist(
      name: AppLanguage.EducationAwarenessText[language],
      image: AppImage.Education_Icon,
    ),
  ];

  void navigateToNextScreen(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, TravelSubCategory.routeName);
    }
    if (index == 1) {
      Navigator.pushNamed(context, LogisticsSubCategory.routeName);
    }
    if (index == 2) {
      Navigator.pushNamed(context, AttendanceSubCategory.routeName);
    }
    if (index == 3) {
      Navigator.pushNamed(context, SampleCollectionSubCategory.routeName);
    }
    if (index == 4) {
      Navigator.pushNamed(context, SampleDepositeSubCategory.routeName);
    }
    if (index == 5) {
      Navigator.pushNamed(context, EducationAwareness.routeName);
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Are you sure you want to logout?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _performLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Login(title: 'Logout Successfull'),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout error: ${e.toString()}')));
    }
  }

  _showAlertDialog(BuildContext context) {
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
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.AreYouSureText[language]),
      content: Text(AppLanguage.ExitAppText[language]),
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

  Future<void> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'No email found';
      fname = prefs.getString('first_name') ?? 'No email found';
      lname = prefs.getString('last_name') ?? 'No email found';
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getInt('user_id');
      });
    } catch (e) {
      print('Error accessing SharedPreferences: $e');
    }
  }

  Future<void> _initializeData() async {
    await _getUserData(); // Wait for the user ID to be loaded first

    // 2. Now that we are SURE userId is not null, we can call the API.
    if (userId != null) {
      await fetchAvailabilityData();
    } else {
      // Handle the case where the user is not logged in
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchAvailabilityData() async {
    try {
      final url = Uri.parse(
        'https://nadaindia.in/api/web/index.php?r=event/all-my-events&dco_user_id=$userId',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          final List<dynamic> allEvents =
              jsonResponse['data']['availability_details'] ?? [];
          final DateTime now = DateTime.now();
          // --- START: Find Nearest Event Logic ---
          // 1. Filter out past or canceled events
          final List<dynamic> upcomingEvents =
              allEvents.where((event) {
                bool isCancelled =
                    event['dco_availability'][0]['cancellation_status'] == '1';
                if (isCancelled) return false;

                DateTime eventDate = DateTime.parse(event['event_start_date']);
                return eventDate.isAfter(now);
              }).toList();
          // 2. Sort the upcoming events to find the nearest one
          upcomingEvents.sort((a, b) {
            DateTime dateA = DateTime.parse(a['event_start_date']);
            DateTime dateB = DateTime.parse(b['event_start_date']);
            return dateA.compareTo(dateB);
          });

          // 3. Get the first event if the list is not empty
          final Map<String, dynamic>? foundEvent =
              upcomingEvents.isNotEmpty ? upcomingEvents.first : null;
          // --- END: Logic ---

          // Update the state with all the fetched data
          setState(() {
            availabilityDetails = allEvents; // The full list
            nearestEvent = foundEvent; // The single nearest event
            bookedEvents = upcomingEvents.length;
          });
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final topCardWidth = screenWidth * 0.65;

    return WillPopScope(
      onWillPop: () {
        return _showAlertDialog(context);
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColor.background,
        body: CustomScrollView(
          slivers: [
            // This is the modern, collapsible app bar
            SliverAppBar(
              backgroundColor: AppColor.background,
              pinned: true,
              floating: true,
              // Decreased height for a tighter look
              expandedHeight: 100.0,
              surfaceTintColor: Colors.transparent,

              // --- CHANGED: NADA logo added to the left ---
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('./assets/icon/logo.png', width: 40, height: 40),
              ),
              // --- CHANGED: Notification icon removed ---
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: AppColor.error,
                    radius: 20,
                    child: IconButton(
                      onPressed: () {
                        _showLogoutConfirmationDialog(context);
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],


              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Welcome, $fname',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary, // Can be any solid color, as it's masked
                  ),
                  maxLines: 1,

                  overflow:
                  TextOverflow
                      .ellipsis
                ),
                centerTitle: true,
                titlePadding: EdgeInsets.all(10),
                ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      // Wrap your existing Stack with a ClipRRect to round the corners of the accent strip
                      Container(
                        height: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: AppColor.accent.withOpacity(0.1),
                            width: 1,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.card,
                              AppColor.accent.withOpacity(0.1),
                            ],
                          ),
                        ),
                        // Use ClipRRect to round the corners of the accent strip
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                            children: [
                              // --- Layer 1: The Accent Strip (at the bottom) ---
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 5.0,
                                  // The height of your accent strip
                                  color: AppColor.accent,
                                ),
                              ),

                              // --- Layer 2: All of your content ---
                              Material(
                                color: Colors.transparent,

                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      createSlideRoute(
                                        const EventSubCategory(),
                                      ),
                                    );
                                  },

                                  borderRadius: BorderRadius.circular(20.0),

                                  splashColor: AppColor.accent.withOpacity(
                                    0.1,
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(10),

                                    child: Align(
                                      alignment: Alignment.centerLeft,

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Image.asset(
                                            './assets/icon/ic_event.png',
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                15 /
                                                100,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                15 /
                                                100,
                                            color: AppColor.accent,
                                          ),

                                          Text(
                                            "Events",

                                            style: TextStyle(
                                              fontSize: 18,

                                              fontWeight: FontWeight.bold,

                                              color: AppColor.textOnAccent,
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                "View All",
                                                style: TextStyle(
                                                  fontSize: 13,

                                                  fontWeight:
                                                      FontWeight.bold,

                                                  color: AppColor.accent,
                                                ),
                                              ),

                                              Icon(
                                                Icons.arrow_forward_ios,

                                                size: 12,

                                                color: AppColor.accent
                                                    .withOpacity(0.9),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //--- Layer 2: The Top Card (Details) ---
                              Positioned(
                                right: 0,

                                top: 0,

                                bottom: 0,

                                width: topCardWidth,

                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 15,
                                    left: 10,
                                    right: 10,
                                  ),

                                  child:
                                      (nearestEvent == null)
                                          ? Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.card,
                                              // A solid white for contrast
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    20.0,
                                                  ),
                                              border: Border.all(
                                                color: AppColor.accent,
                                                width: 1,
                                              ),
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0,
                                                    ),

                                                child: Center(
                                                  child: Text(
                                                    "\u2022 No booked events found...",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          AppColor
                                                              .textSecondary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          : Builder(
                                            builder: (context) {
                                              // Extract and format data here
                                              final String location =
                                                  nearestEvent!['location'] ??
                                                  'N/A';
                                              final String state =
                                                  nearestEvent!['state'] ??
                                                  'N/A';
                                              final DateTime
                                              eventDate = DateTime.parse(
                                                nearestEvent!['event_start_date'],
                                              );
                                              final String formattedDate =
                                                  DateFormat(
                                                    'MMMM d, h:mm a',
                                                  ).format(eventDate);
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: AppColor.card,
                                                  // A solid white for contrast
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.0,
                                                      ),
                                                  border: Border.all(
                                                    color: AppColor.accent,
                                                    width: 1,
                                                  ),
                                                ),

                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16.0,

                                                          vertical: 12.0,
                                                        ),

                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,

                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,

                                                      children: [
                                                        Text(
                                                          location,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                AppColor
                                                                    .textSecondary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 4,
                                                        ),

                                                        Text(
                                                          formattedDate,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,

                                                            fontSize: 16,

                                                            color:
                                                                AppColor
                                                                    .textPrimary,
                                                          ),

                                                          maxLines: 2,

                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          '\u2022 $bookedEvents Upcoming Event(s)',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                AppColor
                                                                    .textSecondary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14.0,
                        controller: ScrollController(
                          keepScrollOffset: false,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: List.generate(event.length, (index) {
                          return Card(
                            elevation: 4,
                            // Controls the shadow size.
                            shadowColor: Colors.black.withOpacity(0.07),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            color: AppColor.card,
                            child: InkWell(
                              onTap: () {
                                navigateToNextScreen(index);
                              },
                              splashColor: AppColor.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColor.card, // e.g., Colors.white
                                      AppColor.accent.withOpacity(0.05),
                                    ],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: -20,
                                      bottom: -30,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: AppColor.accent
                                              .withOpacity(0.16),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -5,
                                      bottom: -50,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: AppColor.accent
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height: 5.0,
                                        color: AppColor.accent,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            event[index].image,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                15 /
                                                100,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                15 /
                                                100,
                                            color: AppColor.accent,
                                          ),
                                          const Spacer(),
                                          Text(
                                            event[index].name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColor.textOnAccent,
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
                        }),
                      ),
                      Heading(title: AppLanguage.UserText[language]),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 3 / 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IdCardDetails(),
                            ),
                          );
                        },
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * 90 / 100,
                          height:
                              MediaQuery.of(context).size.height * 18 / 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: AppTheme.nueshadow,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImage.userCardIcon,
                                width:
                                    MediaQuery.of(context).size.width *
                                    10 /
                                    100,
                                height:
                                    MediaQuery.of(context).size.width *
                                    10 /
                                    100,
                              ),
                              SizedBox(height: 5),
                              Text(
                                AppLanguage.IDCardText[language],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Eventlist {
  String name, image;

  Eventlist({required this.name, required this.image});
}

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 100 / 100,
      height: MediaQuery.of(context).size.height * 6 / 100,
      alignment: Alignment.centerLeft,
      color: AppColor.themeColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: AppFont.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
