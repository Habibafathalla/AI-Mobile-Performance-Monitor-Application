import 'package:ai_device/provider/device_metric_provider.dart';
import 'package:ai_device/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatelessWidget {
  final ChatUser currentUser;
  final ChatUser botUser;
  final List<ChatMessage> messages;
  final Function(ChatMessage) onSendMessage;

  const ChatWidget({
    Key? key,
    required this.currentUser,
    required this.botUser,
    required this.messages,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkProvider = Provider.of<DeviceMetricsProvider>(context); 
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                networkProvider.isConnected ? Icons.wifi : Icons.wifi_off,
                color: networkProvider.isConnected ? Colors.green : Colors.red,
                size: 30,
              ),
              const SizedBox(width: 10),
              const Text(
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
      body: DashChat(
        inputOptions: const InputOptions(
          alwaysShowSend: true,
        ),
        currentUser: currentUser,
        onSend: onSendMessage,
        messages: messages,
        messageOptions: MessageOptions(
          currentUserContainerColor: const Color(0x80757575), 
          containerColor: const Color(0x80757575), 
          messageTextBuilder: (currentMessage, previousMessage, nextMessage) {
            return Text(
              currentMessage.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            );
          },
        ),
      ),
    );
  }
}
