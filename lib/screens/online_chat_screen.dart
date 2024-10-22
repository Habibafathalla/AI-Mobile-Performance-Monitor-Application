import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:provider/provider.dart';

class OnlineModelScreen extends StatefulWidget {
  const OnlineModelScreen({super.key});

  @override
  State<OnlineModelScreen> createState() => _OnlineModelState();
}

class _OnlineModelState extends State<OnlineModelScreen> {
  final _user = ChatUser(id: '1');
  final _bot = ChatUser(id: '2');
  final _chatGpt = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)));

  List<ChatMessage> messages = [];

  void _onSend(ChatMessage message) async {
    // Get insights from providers
    final metricsProvider = Provider.of<DeviceMetricsProvider>(context, listen: false);

    final batteryLevel = metricsProvider.batteryLevel ; 
    final freeMemory = metricsProvider.freeMemory ; 
    final freeStorage = metricsProvider.freeStorage ; 
    final isConnected = metricsProvider.isConnected;

    setState(() {
      messages.insert(0, message);
    });

    // Construct the insights string
    String insights = '''
    Device Insights:
    - Battery Level: $batteryLevel%
    - Free Memory: $freeMemory MB
    - Free Storage: ${freeStorage.toStringAsFixed(2)} GB
    - Wifi: ${isConnected ? 'Yes' : 'No'}
    ''';

    // Combine the user's question with the insights
    String combinedMessage = '${message.text}\n\n$insights';

    List<Map<String, dynamic>> messagesHistory = messages.reversed.map((msg) {
      if (msg.user == _user) {
        return {'role': 'user', 'content': msg.text};
      } else {
        return {'role': 'assistant', 'content': msg.text};
      }
    }).toList();

    // Include the combined message in the request to the model
    var request = ChatCompleteText(
      model: Gpt4oMiniChatModel(),
      messages: [
        ...messagesHistory,
        {'role': 'user', 'content': combinedMessage}, // Send combined message
      ],
      maxToken: 200,
    );

    var response = await _chatGpt.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          messages.insert(
            0,
            ChatMessage(
              text: element.message!.content,
              user: _bot,
              createdAt: DateTime.now(),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChatWidget(
      currentUser: _user,
      botUser: _bot,
      messages: messages,
      onSendMessage: _onSend,
    );
  }
}
