import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  final String message;

  const ChatBuble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xff3369FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

