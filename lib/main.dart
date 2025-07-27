import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nada_dco/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'firebase_options.dart';
import 'package:nada_dco/Screens/Splash.dart';
import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/routes.dart';
import 'package:nada_dco/utilities/app_font.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await _initializeLocalNotifications();
  await _initializeFCM();

  final prefs = await SharedPreferences.getInstance();
  final isAuthenticated = prefs.getInt('user_id') != null;

  runApp(MyApp(isAuthenticated: isAuthenticated));
}

Future<void> _initializeLocalNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

Future<void> _initializeFCM() async {
  try {
    await FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token!);
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      await _updateTokenOnServer(userId, token!);
    }
  
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print('FCM Token refreshed: $newToken');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', newToken);
      final userId = prefs.getInt('user_id');
      if (userId != null) {
        await _updateTokenOnServer(userId, newToken);
      }
    });
  } catch (e) {
    print('Error initializing FCM: $e');
  }
}

Future<void> _updateTokenOnServer(int userId, String token) async {
  final url = Uri.parse('https://nadaindia.in/api/web/index.php?r=user/update-token');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId.toString(),
      'device_token': token,
    }),
  );

  if (response.statusCode == 200) {
    print('Token updated successfully on server.');
  } else {
    print('Failed to update token. Status: ${response.statusCode}, Body: ${response.body}');
  }
}

class MyApp extends StatefulWidget {
  final bool isAuthenticated;

  const MyApp({super.key, required this.isAuthenticated});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isAuthenticated;

  @override
  void initState() {
    super.initState();
    _isAuthenticated = widget.isAuthenticated;
    _setupFCMInteractions();
  }

  void _setupFCMInteractions() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received in foreground: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background: ${message.data}');
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App launched from terminated: ${message.data}');
      }
    });
  }

  void _showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DCO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppFont.fontFamily,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xffD5F274),
        ),
      ),
      routes: routes,
      home: _isAuthenticated ? MainScreen() : Splash(),
      onGenerateRoute: (settings) {
        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(
            builder: (context) => builder(context),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
