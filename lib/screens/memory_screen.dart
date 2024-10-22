
import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:ai_device/widgets/storage_info.dart';
import 'package:memory_info/memory_info.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; 

class MemoryInfoScreen extends StatefulWidget {
  @override
  _MemoryInfoScreenState createState() => _MemoryInfoScreenState();
}

class _MemoryInfoScreenState extends State<MemoryInfoScreen> {
  Memory? _memory;

  @override
  void initState() {
    super.initState();
    getMemoryInfo();
  }

  Future<void> getMemoryInfo() async {
    // print('Attempting to fetch memory info...');

    try {
      Memory memory = await MemoryInfoPlugin().memoryInfo;
      // print('Fetched Memory Info: $memory');

      setState(() {
        _memory = memory;
      });

      Provider.of<DeviceMetricsProvider>(context, listen: false).updateFreeMemory(memory.freeMem?.toInt() ?? 0);

    } on PlatformException catch (e) {
      print('Error fetching memory info: ${e.message}');
    } catch (e) {
      print('Unexpected error: ${e.toString()}');
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    if (_memory != null) {
      // print('Total Memory: ${_memory!.totalMem}');
      // print('Free Memory: ${_memory!.freeMem}');
      // print('Used Memory: ${_memory!.appMem}');
    }

    double usedMemory =
        (_memory?.totalMem?.toDouble() ?? 0) - (_memory?.freeMem?.toDouble() ?? 0);

    return MaterialApp(
      home: Scaffold(
        drawer: const NavDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: getMemoryInfo,
          child: const Icon(Icons.update),
        ),
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text(
            'Memory Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 42, 51, 128),
          iconTheme: const IconThemeData(
            color: Colors.white, 
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StorageWidget(
                usedStorage: usedMemory / 1024, 
                totalStorage: (_memory?.totalMem ?? 0) / 1024, 
              ),
              Center(
                child: Text(
                _memory != null
                    ? 'Total Memory: ' +
                        ((_memory!.totalMem != null && _memory!.totalMem! > 0)
                            ? (_memory!.totalMem! / 1024).toStringAsFixed(2) + ' GB'
                            : '0.00 GB') +
                        '\nFree Memory: ' +
                        ((_memory!.freeMem != null && _memory!.freeMem! > 0)
                            ? (_memory!.freeMem! / 1024).toStringAsFixed(2) + ' GB'
                            : '0.00 GB') 
                    : 'No memory info available.',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

