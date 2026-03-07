import 'package:chatgpt_app/core/services/service_locator.dart';
import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/chat/ui/cubit/ai_chat_cubit.dart';
import 'package:chatgpt_app/features/home/views/components/home_screen_header.dart';
import 'package:chatgpt_app/features/home/views/components/text_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/ai_chat_list.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  List<ChatMessageModel> messages = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AiChatCubit>(),
      child: Scaffold(
        appBar: HomeScreenHeader(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: AiChatList(messages: messages)),
              //text field
              BlocBuilder<AiChatCubit, AiChatState>(
                builder: (context, state) {
                  return TextFieldComponent(
                    messages: messages,
                    controller: controller,
                    onSend: () {
                      if (controller.text.isNotEmpty) {
                        var sendMessageCubit = context.read<AiChatCubit>();
                        var message = ChatMessageModel.fromUserMessage(
                          controller.text,
                        );
                        controller.clear();
                        if (sendMessageCubit.state is AiChatError) {
                          messages.removeLast();
                        }
                        messages.add(message);
                        context.read<AiChatCubit>().getChatResponse(messages);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
