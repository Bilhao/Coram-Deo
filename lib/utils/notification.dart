import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:coramdeo/utils/routes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

void _onSelectNotification(NotificationResponse? response) {
  if (response != null && response.payload != null) {
    Navigator.of(Routes.navigatorKey.currentContext!)
        .pushNamed(response.payload!);
  }
}

class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class Notifier {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_notification'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );
    tz.initializeTimeZones();
  }

  static scheduledNotification(
      CustomNotification notification, TimeOfDay time) async {
    final date = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, time.hour, time.minute);

    var androidDetails = const AndroidNotificationDetails(
      'lembretes',
      'Lembretes',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
    );
    var iosDetails = const DarwinNotificationDetails();

    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notification.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.from(date, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: notification.payload,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static stopNotification(int id) async {
    await _notification.cancel(id);
  }

  static Future<bool?> verifyNotificationPermission() async {
    bool? permission = await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    bool? permission2 = await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestExactAlarmsPermission();

    if (permission == true && permission2 == true) {
      return true;
    } else {
      return false;
    }
  }
}
