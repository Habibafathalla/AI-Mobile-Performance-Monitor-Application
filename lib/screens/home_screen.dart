
import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/screens/gemma_screen.dart';
import 'package:ai_device/screens/online_chat_screen.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final networkProvider = Provider.of<DeviceMetricsProvider>(context); 

    return Scaffold(
      drawer: const NavDrawer(),
      body: networkProvider.isConnected
          ? const OnlineModelScreen() 
          : const ChatScreen(), 
    );
  }
}
