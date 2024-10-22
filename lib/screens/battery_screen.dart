import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/battery_widget.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class BatteryScreen extends StatefulWidget {
  @override
  _BatteryScreenState createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  final Battery _battery = Battery();
  BatteryState? _batteryState;
  int? _batteryLevel;
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _initBatteryInfo();
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

Future<void> _initBatteryInfo() async {
  final batterykProvider = Provider.of<DeviceMetricsProvider>(context, listen: false); 

  try {
    final level = await _battery.batteryLevel;
    print('Fetched Battery Level: $level'); 
    if (mounted) { 
      setState(() {
        _batteryLevel = level;
        batterykProvider.updateBatteryLevel(level); 

       
      });
      
    }

  } catch (e) {
    print('Error fetching battery level: $e');
  }
}


  @override
  void dispose() {
    _batteryStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isCharging = _batteryState == BatteryState.charging;

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Battery Information',
            style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          ),
        backgroundColor: const Color.fromARGB(255, 42, 51, 128),
           iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BatteryWidget(
              batteryLevel: _batteryLevel ?? 0,
              isCharging: isCharging,
            ),
            const SizedBox(height: 20),
            Text(
              'Battery Level: ${_batteryLevel ?? 'Loading...'}%',
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 42, 51, 128),
                ),
            ),
            const SizedBox(height: 10),
            Text(
              'Battery State: ${_batteryState != null ? _batteryState.toString().split('.').last : 'Unknown'}',
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 42, 51, 128),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
