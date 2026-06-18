import 'package:flutter/material.dart';
import 'notify_service.dart';

class ValueProvider with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    NotifyService.showNotification(_value);
    notifyListeners();
  }
}
