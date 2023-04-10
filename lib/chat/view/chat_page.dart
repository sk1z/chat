import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/chat/chat.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatBar(),
      body: Column(
        children: [
          const Expanded(child: MessageList()),
          MessageInput(),
        ],
      ),
    );
  }
}
