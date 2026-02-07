import 'package:chatgpt_app/features/home/views/components/typewriter_text.dart';
import 'package:flutter/material.dart';

class ChatBubleFromAI extends StatelessWidget {
  final String message;

  const ChatBubleFromAI({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 26),
                SizedBox(
                  height: 26,
                  width: 26,
                  child: Image.asset("assets/images/chatbot.png"),
                ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: TypewriterText(
                text: message,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff656565),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
