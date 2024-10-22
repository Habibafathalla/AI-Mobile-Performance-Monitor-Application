import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StorageWidget extends StatelessWidget {
  final double usedStorage; 
  final double totalStorage; 
  const StorageWidget({
    Key? key,
    required this.usedStorage,
    required this.totalStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxStorage = totalStorage > 0 ? totalStorage : 100.0; 
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: maxStorage,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: maxStorage * 0.25, 
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: maxStorage * 0.25,
              endValue: maxStorage * 0.75, 
              color: Colors.blue,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: maxStorage * 0.75,
              endValue: maxStorage,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: usedStorage > 0 ? usedStorage : 0), 
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Used: ${usedStorage.toStringAsFixed(2)} GB',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 42, 51, 128),
                    ),
                  ),
            
                ],
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
