import 'package:flutter/material.dart';

import '../components/chat_bubble_from_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _controller = ScrollController();
  // void _scrollDown() {
  //   _controller.animateTo(
  //     0,
  //     duration: const Duration(seconds: 2),
  //     curve: Curves.easeIn,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: _controller,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return ChatBubleFromAI(message: "messagesList[index].message");
            },
          ),
        ),
      ],
    );
  }
}
