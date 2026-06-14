import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'counter_update_channel',
    'Counter Update',
    description: 'Notifikasi saat nilai counter bertambah',
    importance: Importance.high,
  );

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );

    await _plugin.initialize(settings: settings);

    if (!kIsWeb) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);

      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  Future<void> showCounterUpdate(int value) async {
    if (kIsWeb) {
      final webPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >();

      if (webPlugin?.permissionStatus != WebNotificationPermission.granted) {
        await webPlugin?.requestNotificationsPermission();
      }
    }

    const androidDetails = AndroidNotificationDetails(
      'counter_update_channel',
      'Counter Update',
      channelDescription: 'Notifikasi saat nilai counter bertambah',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      ticker: 'Counter bertambah',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.show(
      id: 1,
      title: 'Counter Update',
      body: 'Nilai counter saat ini: $value',
      notificationDetails: notificationDetails,
    );
  }
}
