import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/TravelDetails.dart';
import 'package:nada_dco/Screens/TravelPlans.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart'; // Keep if Constant.homeTextStyle is used
import 'package:flutter/material.dart';
import '../MainScreen.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'package:nada_dco/utilities/page_transitions.dart'; // Added for custom transitions
import 'package:nada_dco/widgets/sub_cat_card.dart'; // Added for ListItemCard

class TravelSubCategory extends StatefulWidget {
  static String routeName = './TravelSubCategory';
  const TravelSubCategory({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _TravelSubCategoryState createState() => _TravelSubCategoryState();
}

class _TravelSubCategoryState extends State<TravelSubCategory> {
  @override
  Widget build(BuildContext context) {
    // Assuming 'language' is accessible, e.g., from AppConstant
    final int language = 0; // Placeholder: Replace with actual language variable/logic

    return Scaffold(
      backgroundColor: AppColor.background, // Match EventSubCategory
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.background, // Match EventSubCategory
            pinned: true,
            floating: true,
            expandedHeight: 150.0, // Match EventSubCategory
            surfaceTintColor: Colors.transparent, // Match EventSubCategory

            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.textPrimary), // Match EventSubCategory
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(10), // Match EventSubCategory
              title: Text(
                AppLanguage.TravelPlanText[language], // Use relevant text
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary, // Match EventSubCategory
                ),
              ),
              centerTitle: true, // Match EventSubCategory
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width, // Simplified 100/100
              // Set height to fill remaining space, allowing scroll if content overflows
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
              color: AppColor.background, // Match EventSubCategory
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Match EventSubCategory
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08), // Match EventSubCategory (8/100)
                    ListItemCard(
                      icon: Icons.share, // Use Image.asset as iconWidget
                      title: AppLanguage.ShareTicketDetailsText[language], // Use relevant text
                      subtitle: 'Share your travel ticket details', // Add a descriptive subtitle
                      onTap: () {
                        Navigator.pushNamed(context, TravelPlans.routeName);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08), // Match EventSubCategory
                    ListItemCard(
                      icon: Icons.airplane_ticket, // Use Image.asset as iconWidget
                      title: AppLanguage.ViewTicketDetailsText[language], // Use relevant text
                      subtitle: 'View and manage your booked travel details', // Add a descriptive subtitle
                      onTap: () {
                        Navigator.pushNamed(context, TravelDetails.routeName);
                      },
                    ),
                    // Add more SizedBox or cards if needed to make it scrollable
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
