import 'package:flutter/material.dart';

class BatteryWidget extends StatelessWidget {
  final int batteryLevel; 
  final bool isCharging;

  BatteryWidget({
    required this.batteryLevel,
    this.isCharging = false,
  });

  @override
  Widget build(BuildContext context) {
    Color batteryColor = _getBatteryColor(batteryLevel);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(215, 218, 208, 208), 
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Battery Level
        Positioned(
          bottom: 0,
          child: Container(
            width: 146,
            height: 146 * (batteryLevel / 100), 
            decoration: BoxDecoration(
              color: batteryColor, 
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
          ),
        ),
        Positioned(
          child: isCharging
              ? const Icon(
                  Icons.bolt,
                  color: Colors.white,
                  size: 30,
                )
              : Text(
                  '$batteryLevel%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ],
    );
  }

  Color _getBatteryColor(int batteryLevel) {
    if (batteryLevel >= 80) {
      return Colors.green; 
    } else if (batteryLevel >= 30) {
      return Colors.green[800]!; 
    } else if (batteryLevel >= 15) {
      return Colors.yellow; 
    } else {
      return Colors.red; 
    }
  }
}
