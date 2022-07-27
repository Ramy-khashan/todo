import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        //icon show in notification
        AndroidInitializationSettings('@drawable/notificatin_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      required int minute}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(minutes: minute)),
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: 'Main channel notifications',
            playSound: true,
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/notificatin_icon'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
  // NotificationAppLaunchDetails? notificationDetails;

  // Future<NotificationAppLaunchDetails> getNotification() async {
  //  notificationDetails   =
  //       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //   return notificationDetails!;
  // }
}
