import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

const String APP_URL = "https://nadaindia.in/api/web/index.php?r=user/login";

class AppApis {
  static Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final url = Uri.parse(APP_URL);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    final data = jsonDecode(response.body);
    return {'statusCode': response.statusCode, 'data': data};
  }

  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userData['id']);
    await prefs.setString('username', userData['username']);
    await prefs.setString('email', userData['email']);
    await prefs.setString('first_name', userData['first_name'] ?? '');
    await prefs.setString('last_name', userData['last_name'] ?? '');
    await prefs.setInt('user_type_id', userData['user_type_id'] ?? 0);
    await prefs.setInt('active', userData['active'] ?? 0);
  }

  static Future<void> confirmDeployment({
    required BuildContext context, // Add BuildContext as a required parameter
    int? dcoUserId,
    required int eventId,
  }) async {
    // Show a loading SnackBar immediately
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Confirming deployment...'),
        duration: Duration(seconds: 1), // Short duration for loading
      ),
    );

    if (dcoUserId == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: DCO User ID not found.', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
      print('Error: userId not found');
      return;
    }

    final url = Uri.parse('https://nadaindia.in/api/web/index.php?r=event/confirm-deployment');
    final headers = {'Content-Type': 'application/json'};

    final body = json.encode({
      "dco_user_id": dcoUserId,
      "event_id": eventId,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide loading or any previous snackbar

      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deployment confirmed successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
        print('Success: ${response.body}');
      } else {
        // API Error
        String errorMessage = 'Failed to confirm deployment. Status: ${response.statusCode}';
        try {
          // Attempt to parse a specific error message from the API response body
          final responseJson = json.decode(response.body);
          if (responseJson['message'] != null) {
            errorMessage = responseJson['message'];
          }
        } catch (e) {
          // If JSON parsing fails, use the default error message
          print('Failed to parse error response body: $e');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                // Just dismiss
              },
            ),
          ),
        );
        print('Failed: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      // Network or other Exception
      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network Error: ${e.toString()}', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: () {
              // Option to retry the deployment
              confirmDeployment(context: context, dcoUserId: dcoUserId, eventId: eventId);
            },
          ),
        ),
      );
      print('Error: $e');
    }
  }
}
