import 'package:nada_dco/Screens/Events.dart';
import 'package:nada_dco/Screens/EventsDetails.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/material.dart';
import 'package:nada_dco/utilities/page_transitions.dart';
import '../MainScreen.dart';
import '../utilities/app_color.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import '../utilities/app_theme.dart';
import '../widgets/sub_cat_card.dart';

class EventSubCategory extends StatefulWidget {
  static String routeName = './EventSubCategory';

  const EventSubCategory({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EventSubCategoryState createState() => _EventSubCategoryState();
}

class _EventSubCategoryState extends State<EventSubCategory> {
  @override
  Widget build(BuildContext context) {
    var Overflow;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.background,
            pinned: true,
            floating: true,
            // Decreased height for a tighter look
            expandedHeight: 150.0,
            surfaceTintColor: Colors.transparent,

            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.textPrimary),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  createSlideLeftToRightRoute(const MainScreen()),
                  (route) => false,
                );
              },
            ),

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(10),
              title: Text(
                'Events',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: AppColor.background,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                    ListItemCard(
                      icon: Icons.event,
                      title: 'Upcoming events',
                      subtitle: 'Mark your availability for upcoming events',
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Events()),
                        );
                      }),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                    ListItemCard(
                      icon: Icons.event,
                      title: 'My events',
                      subtitle: 'View and manage details for booked events',
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventsDetails(),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
