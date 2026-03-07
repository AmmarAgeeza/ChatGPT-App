import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/home/views/components/chat_bubble_from_ai.dart';
import 'package:flutter/material.dart';

import '../../../home/data/models/chat_message_model.dart';
import '../../../home/views/components/chat_bubble.dart';

class LoadingChatListView extends StatelessWidget {
  const LoadingChatListView({super.key, required this.messages});

  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const ChatBubleFromAI(message: "Thinking...");
        }
        var reversedMessages = messages.reversed.toList();
        final msg = reversedMessages[index - 1];
        return msg.isUser
            ? ChatBuble(
                message: ChatMessage(text: msg.displayText, isUser: msg.isUser),
              )
            : ChatBubleFromAI(message: msg.displayText, animate: false);
      },
    );
  }
}
