import 'package:chatgpt_app/core/utils/commons.dart';
import 'package:chatgpt_app/features/home/views/components/chat_bubble.dart';
import 'package:chatgpt_app/features/home/views/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/chat_bubble_from_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatFailure) {
                context.showToastMsg(
                  msg: "Oops, something went wrong",
                  toastState: ToastStates.error,
                );
              }
            },
            builder: (context, state) {
              var messages = context.read<ChatCubit>().messages;
              var isLoading = state is ChatLoading;
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                reverse: true,
                controller: _controller,
                itemCount: messages.length + (isLoading ? 1 : 0),
                itemBuilder: (ctx, index) {
                  if (isLoading && index == 0) {
                    return const ChatBubleFromAI(message: "Thinking...");
                  }
                  var realIndex = isLoading ? index - 1 : index;
                  var message = messages[realIndex];
                  if (message.isUser) {
                    return ChatBuble(
                      message: message,
                      onRetry: () {
                        context.read<ChatCubit>().retry(realIndex);
                      },
                    );
                  } else {
                    return ChatBubleFromAI(
                      message: message.text,
                      animate: message.shouldAnimate,
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
