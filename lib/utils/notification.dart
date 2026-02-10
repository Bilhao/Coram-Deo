import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:coramdeo/utils/routes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

void _onSelectNotification(NotificationResponse? response) {
  try {
    if (response != null && response.payload != null) {
      final context = Routes.navigatorKey.currentContext;
      if (context != null) {
        Navigator.of(context).pushNamed(response.payload!);
      }
    }
  } catch (e) {
    // Log error but don't crash the app
    debugPrint('Error handling notification: $e');
  }
}

class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification({required this.id, required this.title, required this.body, required this.payload});
}

class Notifier {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _notification.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_notification'), iOS: DarwinInitializationSettings()),
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );
    tz_data.initializeTimeZones();
  }

  static Future<void> scheduledNotification(CustomNotification notification, TimeOfDay time) async {
    try {
      final date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute);

      var androidDetails = const AndroidNotificationDetails('lembretes', 'Lembretes', importance: Importance.max, priority: Priority.max, playSound: true, enableVibration: true);
      var iosDetails = const DarwinNotificationDetails();

      var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

      await _notification.zonedSchedule(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        scheduledDate: tz.TZDateTime.from(date, tz.local),
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: notification.payload,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
      rethrow;
    }
  }

  static Future<void> stopNotification(int id) async {
    try {
      await _notification.cancel(id: id);
    } catch (e) {
      debugPrint('Error stopping notification: $e');
      rethrow;
    }
  }

  static Future<bool?> verifyNotificationPermission() async {
    try {
      bool? permission = await _notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
      bool? permission2 = await _notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();

      return permission == true && permission2 == true;
    } catch (e) {
      debugPrint('Error verifying notification permission: $e');
      return false;
    }
  }

  static Future<bool> checkNotificationPermission() async {
    try {
      final bool? result = await _notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();
      return result ?? false;
    } catch (e) {
      debugPrint('Error checking notification permission: $e');
      return false;
    }
  }
}
