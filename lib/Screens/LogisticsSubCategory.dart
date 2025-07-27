import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/Logistics.dart';
import 'package:nada_dco/Screens/ViewLogisticsDetails.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart'; // Keep if Constant.appBarCenterTitleStyle is used
import 'package:flutter/material.dart';
import '../MainScreen.dart';
import '../utilities/app_color.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'package:nada_dco/utilities/page_transitions.dart'; // Added for custom transitions
import 'package:nada_dco/widgets/sub_cat_card.dart'; // Added for ListItemCard

class LogisticsSubCategory extends StatefulWidget {
  static String routeName = './LogisticsSubCategory';

  const LogisticsSubCategory({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LogisticsSubCategoryState createState() => _LogisticsSubCategoryState();
}

class _LogisticsSubCategoryState extends State<LogisticsSubCategory> {
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
                AppLanguage.LogisticsText[language], // Use relevant text
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
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
              color: AppColor.background, // Match EventSubCategory
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Match EventSubCategory
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08), // Match EventSubCategory (8/100)
                    ListItemCard(
                      icon: Icons.share, // Use Image.asset as iconWidget
                      title: AppLanguage.ShareLogisticsDetailsText[language], // Use relevant text
                      subtitle: 'Share logistics information', // Add a descriptive subtitle
                      onTap: () {
                        Navigator.pushNamed(context, Logistics.routeName);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08), // Match EventSubCategory
                    ListItemCard(
                      icon: Icons.local_shipping, // Use Image.asset as iconWidget
                      title: AppLanguage.ViewLogisticsDetailsText[language], // Use relevant text
                      subtitle: 'View and manage logistics details', // Add a descriptive subtitle
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewLogisticsDetails(),
                          ),
                        );
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
