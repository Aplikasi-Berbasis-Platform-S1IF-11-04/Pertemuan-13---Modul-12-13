import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Konfigurasi untuk Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Konfigurasi untuk iOS/macOS
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Minta izin notifikasi (Android 13+)
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showCounterNotification(int counterValue) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'counter_channel', // channel id
      'Counter Notifications', // channel name
      channelDescription: 'Notifikasi untuk perubahan nilai counter',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Counter Update',
      styleInformation: BigTextStyleInformation(''),
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0, // notification id (0 agar selalu replace notifikasi sebelumnya)
      'Counter Update', // judul notifikasi
      'Nilai counter saat ini: $counterValue', // pesan notifikasi
      notificationDetails,
    );
  }
}
