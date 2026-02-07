import 'package:chatgpt_app/features/home/views/components/chat_suggestions_component.dart';
import 'package:chatgpt_app/features/home/views/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../components/home_screen_header.dart';
import '../components/text_field_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatCubit>(),
      child: Scaffold(
        appBar: HomeScreenHeader(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //chat suggestions
                Expanded(child: ChatSuggestionsComponent()),
                //text field
                TextFieldComponent(isSugget: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
