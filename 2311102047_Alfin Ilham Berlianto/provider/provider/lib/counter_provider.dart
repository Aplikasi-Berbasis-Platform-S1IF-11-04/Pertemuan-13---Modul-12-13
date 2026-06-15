import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  // Getter untuk mengambil nilai counter
  int get count => _count;

  // Fungsi untuk menambah nilai counter dan memicu notifikasi
  void increment() {
    _count++;
    notifyListeners(); // Memberitahu UI untuk memperbarui tampilan
    NotificationService.showNotification(_count); // Picu local notification
  }
}