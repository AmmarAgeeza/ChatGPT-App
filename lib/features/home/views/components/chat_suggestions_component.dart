import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat_suggestions_model.dart';
import '../cubit/chat_cubit.dart';
import 'chat_suggestion_header_component.dart';

class ChatSuggestionsComponent extends StatelessWidget {
  const ChatSuggestionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        ChatSuggestionModel.suggestionsList.length,
        (index) => Column(
          children: [
            ChatSuggetionHeaderComponent(
              image: ChatSuggestionModel.suggestionsList[index].imagePath,
              title: ChatSuggestionModel.suggestionsList[index].title,
            ),
            ...List.generate(
              ChatSuggestionModel.suggestionsList[index].suggestions.length,
              (i) => TextButton(
                onPressed: () {
                  context.read<ChatCubit>().sendMessage(
                    ChatSuggestionModel.suggestionsList[index].suggestions[i],
                  );
                },
                child: Text(
                  ChatSuggestionModel.suggestionsList[index].suggestions[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3E3E3E),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
