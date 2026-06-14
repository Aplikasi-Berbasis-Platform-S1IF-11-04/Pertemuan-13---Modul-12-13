import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  static Future<void> showNotification(int counter) async {
    print("NOTIF DIPANGGIL: $counter");

    await flutterLocalNotificationsPlugin.show(
      0,
      'Counter Update',
      'Nilai counter saat ini: $counter',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'counter_channel',
          'Counter Notification',
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
    );
  }
}