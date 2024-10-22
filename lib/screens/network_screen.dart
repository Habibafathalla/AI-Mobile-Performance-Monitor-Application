import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class NetworkScreen extends StatefulWidget {

  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkState();
}

class _NetworkState extends State<NetworkScreen> {
  String _wifiName = 'Unknown'; 
  bool _isConnected = false; 

  @override
  void initState() {
    super.initState();
    _initNetworkInfo(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: const NavDrawer(),
      appBar: AppBar(
         toolbarHeight: 80,
        centerTitle: true,
           iconTheme: const IconThemeData(
        color: Colors.white, 
      ),
        backgroundColor: const Color.fromARGB(255, 42, 51, 128),
        title: const Text(
          'Network Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Wi-Fi Information',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 51, 128),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isConnected ? Icons.wifi : Icons.wifi_off,
                  color: _isConnected ? Colors.green : Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 8),
                Text(
                  _wifiName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 42, 51, 128),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initNetworkInfo() async {
    String? wifiName;
    final networkProvider = Provider.of<DeviceMetricsProvider>(context, listen: false); 

    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        if (await Permission.locationWhenInUse.request().isGranted) {
          wifiName = await NetworkInfo().getWifiName(); 
        } else {
          wifiName = 'Unauthorized to get Wi-Fi Name';
        }
      } else {
        wifiName = await NetworkInfo().getWifiName(); 
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wi-Fi Name', error: e);
      wifiName = 'Failed to get Wi-Fi Name';
    }

    setState(() {
      _isConnected = (wifiName != null && wifiName.isNotEmpty);
      _wifiName = _isConnected ? wifiName! : 'No network is connected'; 
      networkProvider.updateNetworkStatus(_isConnected); 
    });
  }
}


