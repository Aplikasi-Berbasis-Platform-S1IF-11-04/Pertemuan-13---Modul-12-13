import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  Future<void> incrementCounter() async {
    _counter++;

    await NotificationService.showNotification(
      title: 'Counter Update',
      body: 'Nilai counter saat ini: $_counter',
    );

    notifyListeners();
  }
}