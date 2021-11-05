import 'package:clock_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AndroidInitializationSettings initializationsForAndroid =
      const AndroidInitializationSettings('Flutter');

  IOSInitializationSettings iosInitializationSettings =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification:
              (int id, String? title, String? body, String? payload) async {});

  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationsForAndroid, iOS: iosInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload' + payload);
    }
  });
  runApp(const MyApp());
}
