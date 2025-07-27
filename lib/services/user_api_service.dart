// lib/services/user_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nada_dco/models/user_profile.dart'; // Import your updated model

class UserApiService {
  static const String _baseUrl = 'https://nadaindia.in/api/web/index.php?r=user/user-profile';

  Future<UserProfile> fetchUserProfile(String dcoUserId) async {
    final String apiUrl = '$_baseUrl&dco_user_id=$dcoUserId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // *** CRUCIAL CHANGE HERE: Check for 'status': true (boolean) ***
        // And ensure 'data' is a Map and contains a 'user' Map
        if (responseData['status'] == true && responseData['data'] is Map && responseData['data']['user'] is Map) {
          // Pass the entire responseData map to fromJson, as it expects the outer structure
          return UserProfile.fromJson(responseData['data']);
        } else {
          // This block now correctly handles cases where status is not true,
          // or data/user object is missing/malformed.
          final String message = responseData['message']?.toString() ?? 'Unknown API response';
          throw Exception('API Error: $message');
        }
      } else {
        throw Exception('Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}