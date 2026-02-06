import 'package:flutter/material.dart';

import '../components/chat_suggestions_component.dart';
import '../components/home_screen_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeScreenHeader(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            //chat suggestions
            ChatSuggestionsComponent(),
            //text field
          ],
        ),
      ),
    );
  }
}
