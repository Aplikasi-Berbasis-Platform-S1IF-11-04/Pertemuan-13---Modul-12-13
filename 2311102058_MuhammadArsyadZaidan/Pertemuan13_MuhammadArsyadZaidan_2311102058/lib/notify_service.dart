import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await _plugin.initialize(settings);
  }

  static Future<void> showNotification(int value) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Counter Channel',
      channelDescription: 'Notifikasi setiap nilai bertambah',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(0, 'Counter Update', 'Nilai sekarang: $value', details);
  }
}
