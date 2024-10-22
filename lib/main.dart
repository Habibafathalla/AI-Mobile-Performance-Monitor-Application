import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (context) => DeviceMetricsProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  
}

class _MyAppState extends State<MyApp> {

  @override

  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'PerfMonitor AI',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 246, 251, 252),
          surface: const Color.fromARGB(255, 42, 51, 128),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 251, 251),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.black,
              ),
            ),
      ),
 
      home: const SplashScreen(),
      initialRoute: 'home',
    );
  }
}