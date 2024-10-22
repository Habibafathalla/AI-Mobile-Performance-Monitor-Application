import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:provider/provider.dart';
import 'package:ai_device/widgets/gemma_chat_widget.dart';

class OnlineModelScreen extends StatefulWidget {
  const OnlineModelScreen({super.key});

  @override
  State<OnlineModelScreen> createState() => _OnlineModelState();
}

class _OnlineModelState extends State<OnlineModelScreen> {
  final List<Message> _messages = [];
  final _chatGpt = OpenAI.instance.build(
    token: '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',
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
  );

  bool _isModelInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  Future<void> _initializeModel() async {
    await Future.delayed(const Duration(seconds: 3)); 
    setState(() {
      _isModelInitialized = true;
    });
  }

  void _onSendMessage(String userQuestion) async {
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

    String combinedMessage = '$userQuestion\n\n$insights';
    print(insights);

    setState(() {
      _messages.add(Message(text: userQuestion, isUser: true));
    });

    List<Map<String, dynamic>> messagesHistory = _messages.map((msg) {
      return msg.isUser
          ? {'role': 'user', 'content': msg.text}
          : {'role': 'assistant', 'content': msg.text};
    }).toList();

    var request = ChatCompleteText(
      model: Gpt4oMiniChatModel(),
      messages: [
        ...messagesHistory,
        {'role': 'user', 'content': combinedMessage},  
      ],
      maxToken: 512,
    );

    var response = await _chatGpt.onChatCompletion(request: request);

    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.add(
            Message(text: element.message!.content, isUser: false),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ChatListWidget(
                humanHandler: _onSendMessage,
                gemmaHandler: (Message message) {
                  setState(() {
                    _messages.add(message);  
                  });
                },
                messages: _messages,
              )

      ],
    );
  }
}
