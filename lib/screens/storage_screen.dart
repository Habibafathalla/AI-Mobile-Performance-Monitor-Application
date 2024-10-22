import 'dart:async';
import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:ai_device/widgets/storage_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage_info/flutter_storage_info.dart';
import 'package:provider/provider.dart';


class StorageInfoPage extends StatefulWidget {
  const StorageInfoPage({super.key});

  @override
  StorageInfoPageState createState() => StorageInfoPageState();
}

class StorageInfoPageState extends State<StorageInfoPage>
    with SingleTickerProviderStateMixin {
  double _internalStorageFreeSpace = 0.0;
  double _internalStorageUsedSpace = 0.0;
  double _internalStorageTotalSpace = 0.0;


  @override
  void initState() {
    super.initState();
    _fetchStorageInfo();


  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchStorageInfo() async {
   final storageProvider = Provider.of<DeviceMetricsProvider>(context, listen: false); // Get the provider

    _internalStorageFreeSpace =
        await FlutterStorageInfo.getStorageFreeSpaceInGB;
    _internalStorageUsedSpace =
        await FlutterStorageInfo.getStorageUsedSpaceInGB;
    _internalStorageTotalSpace =
        await FlutterStorageInfo.getStorageTotalSpaceInGB;

    setState(() {
      storageProvider.updateFreeStorage(_internalStorageFreeSpace);
     

    });
  }

  String _formatSpace(double space) {
    if (space < 1) {
      return "${(space * 1024).toStringAsFixed(2)} MB";
    } else {
      return "${space.toStringAsFixed(2)} GB";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Storage Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor:const Color.fromARGB(255, 42, 51, 128),
           iconTheme: const IconThemeData(
        color: Colors.white, 
      ),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
       
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StorageWidget(
                usedStorage: _internalStorageUsedSpace,
                totalStorage: _internalStorageTotalSpace,
              ),
              const SizedBox(height: 20),
              Text(
                'Free: ${_formatSpace(_internalStorageFreeSpace)}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Used: ${_formatSpace(_internalStorageUsedSpace)}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Total: ${_formatSpace(_internalStorageTotalSpace)}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
