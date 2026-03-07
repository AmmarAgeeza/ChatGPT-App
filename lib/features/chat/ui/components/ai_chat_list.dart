import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/chat/ui/cubit/ai_chat_cubit.dart';
import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/home/views/components/chat_bubble.dart';
import 'package:chatgpt_app/features/home/views/components/chat_suggestions_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/views/components/chat_bubble_from_ai.dart';

class AiChatList extends StatelessWidget {
  const AiChatList({super.key, required this.messages});
  final List<ChatMessageModel> messages;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiChatCubit, AiChatState>(
      listener: (context, state) {
        if (state is AiChatError) {}
        if (state is AiChatLoaded) {
          messages.add(state.chatMessage);
        }
      },
      builder: (context, state) {
        if (messages.isEmpty) {
          return ChatSuggestionsComponent(messages: messages);
        }
        if (state is AiChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AiChatError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is AiChatLoaded) {
          return ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var reversedMessages = messages.reversed.toList();
              final msg = reversedMessages[index];
              return msg.isUser
                  ? ChatBuble(
                      message: ChatMessage(
                        text: msg.displayText,
                        isUser: msg.isUser,
                      ),
                    )
                  : ChatBubleFromAI(
                      message: msg.displayText,
                      animate: index == 0,
                    );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
