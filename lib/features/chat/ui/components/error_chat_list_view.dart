import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/chat/ui/cubit/ai_chat_cubit.dart';
import 'package:chatgpt_app/features/home/views/components/chat_bubble_from_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/chat_message_model.dart';
import '../../../home/views/components/chat_bubble.dart';

class ErrorChatListView extends StatelessWidget {
  const ErrorChatListView({super.key, required this.messages});
  final List<ChatMessageModel> messages;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        // if (index == 0) {
        //   return const ChatBubleFromAI(
        //     message: "Something went wrong. Please try again.",
        //     animate: false,
        //   );
        // }
        var reversedMessages = messages.reversed.toList();
        final msg = reversedMessages[index];
        return msg.isUser
            ? ChatBuble(
                message: ChatMessage(
                  text: msg.displayText,
                  isUser: msg.isUser,
                  status: MessageStatus.error,
                ),
                onRetry: () {
                  messages.removeAt(index);
                  messages.add(
                    ChatMessageModel.fromUserMessage(msg.displayText),
                  );
                  context.read<AiChatCubit>().getChatResponse(messages);
                },
              )
            : ChatBubleFromAI(message: msg.displayText, animate: false);
      },
    );
  }
}
