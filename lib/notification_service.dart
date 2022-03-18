import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz; 
import 'package:timezone/timezone.dart'; 


class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotif = BehaviorSubject<String?>();
  // static final tz = TimeZone(0,); 

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id', 
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS : IOSNotificationDetails(),
    ); 
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher'); 
    final iOS = IOSInitializationSettings(); 
    final settings = InitializationSettings(android: android, iOS: iOS); 
    await _notifications.initialize(settings, onSelectNotification: (payload) async {
      onNotif.add(payload); 
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body, 
    String? payload,
  }) async => _notifications.show(id, title, body, await _notificationDetails(), payload: payload);

  // static void showSchedNotif({
  //   int id = 0,
  //   String? title, 
  //   String? body, 
  //   String? payload, 
  //   required DateTime scheduledDate, 
  // }) async => _notifications.zonedSchedule(
  //   id, 
  //   title, 
  //   body, 
  //   tz.TZDateTime.from(scheduledDate, tz.local),
  //   await _notificationDetails(),
  //   payload: payload
  // );
}