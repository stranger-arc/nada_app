import 'package:flutter/material.dart';
import 'package:nada_dco/Screens/EditProfile.dart';
import 'package:nada_dco/Screens/Settings.dart';
import 'package:nada_dco/common/bottom_nav.dart';
import 'package:nada_dco/models/user_profile.dart'; // Your UserProfile model
import 'package:nada_dco/services/user_api_service.dart'; // Your UserApiService
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/widgets/profile_shimmer_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nada_dco/utilities/app_constant.dart';

import '../utilities/app_language.dart';
import 'Login.dart'; // <-- ADD THIS LINE

class Profile extends StatefulWidget {
  final String? userId;

  const Profile({Key? key, this.userId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // --- ALL YOUR EXISTING LOGIC AND STATE VARIABLES ARE PRESERVED ---
  late Future<UserProfile>? _userProfileFuture;
  final UserApiService _apiService = UserApiService();

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  _showAlertDialog1(BuildContext context) {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(title: '')),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLanguage.LogoutModelText[language]),
      content: Text(AppLanguage.ExitLogout[language]),
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

  Future<void> _initializeProfile() async {
    String? finalUserId = widget.userId;

    // If no ID was passed from a parent widget, try to get it from storage.
    if (finalUserId == null) {
      final prefs = await SharedPreferences.getInstance();
      final loadedId = prefs.getInt('user_id');
      finalUserId = loadedId?.toString();
    }

    // Now, set the future for the FutureBuilder.
    setState(() {
      if (finalUserId != null && finalUserId.isNotEmpty) {
        // If we have a valid ID, call the API.
        _userProfileFuture = _apiService.fetchUserProfile(finalUserId!);
      } else {
        // If there's no ID, create a future that returns an error.
        _userProfileFuture = Future.error(
          "User ID not found. Please log in again.",
        );
      }
    });
  }

  // --- ONLY THE BUILD METHOD AND UI HELPERS ARE UPDATED ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        // Make the AppBar itself transparent
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // Removes default back button
        title: const Text(
          "Profile",
          style: TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        //can be implemented later
        // actions: [
        //   IconButton(
        //     onPressed:
        //         () => Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => Settings(title: "")),
        //         ),
        //     icon: const Icon(
        //       Icons.settings_outlined,
        //       color: AppColor.textSecondary,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed:
        //         () => Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const EditProfile()),
        //         ),
        //     icon: const Icon(
        //       Icons.edit_outlined,
        //       color: AppColor.textSecondary,
        //     ),
        //   ),
        // ],
      ),
      body: FutureBuilder<UserProfile>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can use your existing shimmer loader
            return const ProfileShimmerLoader();
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Failed to load profile: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accent,
                      ),
                      onPressed: () => _initializeProfile,
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: AppColor.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 100.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: AppColor.accent,
                    child: Text(
                      user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textOnAccent,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name.isEmpty ? "Not Available" : user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    backgroundColor: AppColor.accent.withOpacity(0.5),
                    // Chip color
                    shape: StadiumBorder(
                      side: BorderSide(color: AppColor.accent.withOpacity(0.5)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    label: Text(
                      'Unique Id: ${user.uniqueId}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.border,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Organized Information Cards ---
                  _buildInfoCard(
                    title: "Personal Details",
                    children: [
                      _buildInfoRow(
                        icon: Icons.person,
                        label: "Gender",
                        value: user.gender.isEmpty ? "Not Available" : user.gender,
                      ),
                      _buildInfoRow(
                        icon: Icons.cake,
                        label: "DOB",
                        value: user.dob.isEmpty ? "Not Available" : user.dob,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    title: "Contact Details",
                    children: [
                      _buildInfoRow(
                        icon: Icons.smartphone,
                        label: "Primary Mobile No.",
                        value:
                            user.primaryMobileNo.isEmpty
                                ? "Not Available"
                                : user.primaryMobileNo,
                      ),
                      _buildInfoRow(
                        icon: Icons.phone,
                        label: "Secondary Mobile No.",
                        value: user.secondaryMobileNo ?? "Not Available",
                      ),
                      _buildInfoRow(
                        icon: Icons.email,
                        label: "Email",
                        value: user.email ?? "Not Available",
                      ),
                      _buildInfoRow(
                        icon: Icons.home_work,
                        label: "Address",
                        value: user.address.isEmpty ? "Not Available" : user.address,
                      ),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: "Permanent Address",
                        value: user.permanentAddress ?? "Not Available",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    title: "Professional Details",
                    children: [
                      _buildInfoRow(
                        icon: Icons.map,
                        label: "State",
                        value: user.state.isEmpty ? "Not Available" : user.state,
                      ),
                      _buildInfoRow(
                        icon: Icons.location_city,
                        label: "City",
                        value: user.city.isEmpty ? "Not Available" : user.city,
                      ),
                      _buildInfoRow(
                        icon: Icons.badge,
                        label: "Designation",
                        value:
                            user.designation.isEmpty ? "Not Available" : user.designation,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Dedicated Actions Card ---
                  _buildActionCard(
                    icon: Icons.logout,
                    title: "Log Out",
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No user data available.'));
        },
      ),
    );
  }

  // --- NEW UI HELPER WIDGETS ---

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColor.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.accent, size: 24), // The new icon
          const SizedBox(width: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: AppColor.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              softWrap: true,
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      splashColor: Colors.red.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColor.card,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.red, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
