import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/chat/ui/cubit/ai_chat_cubit.dart';
import 'package:chatgpt_app/features/home/views/components/chat_suggestions_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_chat_list_view.dart';
import 'loaded_chat_list_view.dart';
import 'loading_chat_list_view.dart';

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
          return LoadingChatListView(messages: messages);
        }
        if (state is AiChatError) {
          return ErrorChatListView(messages: messages);
        }
        if (state is AiChatLoaded) {
          return LoadedChatListView(messages: messages);
        }
        return const SizedBox();
      },
    );
  }
}
