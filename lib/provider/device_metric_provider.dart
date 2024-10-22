import 'package:flutter/material.dart';

class DeviceMetricsProvider with ChangeNotifier {
  int _batteryLevel = 0;
  int _freeMemory = 0;
  double _freeStorage = 0;
  bool _isConnected = false;

  int get batteryLevel => _batteryLevel;
  int get freeMemory => _freeMemory;
  double get freeStorage => _freeStorage;
    bool get isConnected => _isConnected;


  void updateBatteryLevel(int level) {
    _batteryLevel = level;
    notifyListeners();
  }

  void updateFreeMemory(int memory) {
    _freeMemory = memory; 
    notifyListeners();
  }

  void updateFreeStorage(double storage) {
    _freeStorage = storage;
    notifyListeners();
  }
 void updateNetworkStatus(bool status) {
    _isConnected = status;
    notifyListeners(); 
  }

}
