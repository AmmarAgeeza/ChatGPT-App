import 'package:flutter/material.dart';

import '../components/home_screen_header.dart';
import '../components/text_field_component.dart';
import 'chat_screen.dart';

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
              Expanded(child: ChatScreen()),
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
