import 'package:nada_dco/Screens/DepositeSamples.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart'; // Keep if Constant.appBarCenterTitleStyle is used
import 'package:flutter/material.dart';
import '../MainScreen.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'ViewDepositeSampleDetail.dart';
import 'package:nada_dco/utilities/page_transitions.dart'; // Added for custom transitions
import 'package:nada_dco/widgets/sub_cat_card.dart'; // Added for ListItemCard

class SampleDepositeSubCategory extends StatefulWidget {
  static String routeName = './SampleDepositeSubCategory';
  const SampleDepositeSubCategory({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SampleDepositeSubCategoryState createState() => _SampleDepositeSubCategoryState();
}

class _SampleDepositeSubCategoryState extends State<SampleDepositeSubCategory> {
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
                AppLanguage.SampleDepositeText[language], // Use relevant text
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
                      icon: Icons.medication_liquid, // Use Image.asset as iconWidget
                      title: AppLanguage.DepositSamplesText[language], // Use relevant text
                      subtitle: 'Deposit collected samples for analysis', // Add a descriptive subtitle
                      onTap: () {
                        Navigator.pushNamed(context, DepositeSamples.routeName);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08), // Match EventSubCategory
                    ListItemCard(
                      icon: Icons.file_copy, // Use Image.asset as iconWidget
                      title: AppLanguage.ViewDepositedSampleDetailsText[language], // Use relevant text
                      subtitle: 'View details of previously deposited samples', // Add a descriptive subtitle
                      onTap: () {
                        Navigator.pushNamed(context, ViewDepositeSampleDetail.routeName);
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
