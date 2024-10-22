import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/gemma_chat_input_field.dart';
import 'package:ai_device/widgets/gemma_chat_message.dart';
import 'package:ai_device/widgets/gemma_input_field.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:provider/provider.dart';


class ChatListWidget extends StatelessWidget {
  const ChatListWidget({
    super.key,
    required this.messages,
    required this.gemmaHandler,
    required this.humanHandler,
  });

  final List<Message> messages;
  final ValueChanged<Message> gemmaHandler;
  final ValueChanged<String> humanHandler;

  @override
  Widget build(BuildContext context) {
  final networkProvider = Provider.of<DeviceMetricsProvider>(context); 
    return Scaffold(
      drawer: const NavDrawer(),
      appBar:   AppBar(
    toolbarHeight: 80,
    title:  Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children:  [
          Icon(
            networkProvider.isConnected
           ?  Icons.wifi
           : Icons.wifi_off,
            color: networkProvider.isConnected
            ? Colors.green
            :Colors.red ,
            size: 30, 
          ),
          const SizedBox(width: 10), 
         const  Text(
            'PerfMonitor AI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ],
      ),
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 42, 51, 128),
    iconTheme: const IconThemeData(
      color: Colors.white, 
    ),
  ),
   
    body: ListView.builder(
      padding: const EdgeInsets.all(8.0),
      reverse: true,
      itemCount: messages.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          if (messages.isNotEmpty && messages.last.isUser) {
            return GemmaInputField(
              messages: messages,
              streamHandled: gemmaHandler,
            );
          }
          if (messages.isEmpty || !messages.last.isUser) {
            return ChatInputField(handleSubmitted: humanHandler);
          }
        } else if (index == 1) {
          return const Divider(height: 1.0);
        } else {
          final message = messages.reversed.toList()[index - 2];
          return ChatMessageWidget(
            message: message,
          );
        }
        return null;
      },
    ),
    );
  }
}