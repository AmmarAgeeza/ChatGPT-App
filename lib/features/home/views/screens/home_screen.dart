import 'package:flutter/material.dart';

import '../components/chat_suggestions_component.dart';
import '../components/home_screen_header.dart';
import '../components/text_field_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              TextFieldComponent(
                controller: TextEditingController(),
                isSugget: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
