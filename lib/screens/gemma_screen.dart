import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/gemma_chat_widget.dart';
import 'package:ai_device/widgets/gemma_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _messages = <Message>[];
  bool _isModelInitialized = false;
  int? _loadingProgress;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  Future<void> _initializeModel() async {
    bool isLoaded = await FlutterGemmaPlugin.instance.isLoaded;
    if (!isLoaded) {
      await for (int progress in FlutterGemmaPlugin.instance
          .loadAssetModelWithProgress(fullPath: 'gemma-2b-it-cpu-int4.bin')) {
        setState(() {
          _loadingProgress = progress;
        });
      }
    }
    await FlutterGemmaPlugin.instance.init(
      maxTokens: 512,
      temperature: 0.6,
      topK: 1,
      randomSeed: 1,
    );
    setState(() {
      _isModelInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        _isModelInitialized
            ? ChatListWidget(
          gemmaHandler: (message) {
            setState(() {
              _messages.add(message);
            });
          },
          humanHandler: (text) {
            final metricsProvider = Provider.of<DeviceMetricsProvider>(context, listen: false);

              final batteryLevel = metricsProvider.batteryLevel;
              final freeMemory = metricsProvider.freeMemory;
              final freeStorage = metricsProvider.freeStorage;
              final isConnected = metricsProvider.isConnected;

              String insights = '''
              Device Insights:
              - Battery Level: $batteryLevel%
              - Free Memory: $freeMemory MB
              - Free Storage: ${freeStorage.toStringAsFixed(2)} GB
              - Wifi: ${isConnected ? 'Yes' : 'No'}
              ''';
              print(insights);

              String combinedMessage = '$text\n\n$insights';
            setState(() {
              _messages.add(Message(text: combinedMessage, isUser: true));
            });
  
          },
          messages: _messages,
        )
            : LoadingWidget(
          message: _loadingProgress == null
              ? 'Model is checking\n\nPlease wait for a few seconds'
              : 'Model loading progress:',
          progress: _loadingProgress,
            ),
      ]
   
      );
  }
}

