import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ai_device/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                 Padding(
                   padding: const EdgeInsets.only(left:30.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                     children:[
                      Image.asset(
                      'assets/images/performance-monitor_logo.png',
                      ),
                     ] 
                   ),
                 ),
                
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to PerfMonitor AI',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                ),
              ],
            )));
  }
}