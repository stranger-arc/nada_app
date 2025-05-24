import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
}
