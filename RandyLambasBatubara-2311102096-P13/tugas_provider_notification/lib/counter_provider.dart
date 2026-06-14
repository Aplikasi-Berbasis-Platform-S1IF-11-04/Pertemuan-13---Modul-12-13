import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CounterProvider with ChangeNotifier {
  int _counter = 0;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int get counter => _counter;

  CounterProvider() {
    _initNotification();
  }

  // 1. Inisialisasi Notifikasi
  Future<void> _initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);

    // Minta izin untuk Android 13 ke atas
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  // 2. Fungsi Menampilkan Notifikasi
  Future<void> _showNotification(int value) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'counter_channel_id', // ID Channel bebas
          'Counter Updates', // Nama Channel bebas
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      0,
      'Counter Update',
      'Nilai counter saat ini: $value',
      platformChannelSpecifics,
    );
  }

  // 3. Fungsi Tambah Counter
  void incrementCounter() {
    _counter++;
    notifyListeners(); // Memberitahu UI untuk update tampilan
    _showNotification(_counter); // Memicu notifikasi lokal
  }
}
