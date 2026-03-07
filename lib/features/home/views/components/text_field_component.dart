// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final List<ChatMessageModel> messages;
  final Function() onSend;
  const TextFieldComponent({
    super.key,
    required this.messages,
    required this.controller,
    required this.onSend,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: messages.isEmpty
            ? "Hello chatGPT,how are you today?"
            : "Write your message",
        hintStyle: messages.isEmpty
            ? TextStyle(
                color: Color(0xff3369FF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )
            : TextStyle(
                color: Color(0xffA1A1A1),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
        border: customBorder(),
        enabledBorder: customBorder(),
        focusedBorder: customBorder(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 18,
                width: 18,
                child: Image.asset("assets/images/microphone-2.png"),
              ),
            ),
            SizedBox(width: 12),
            InkWell(
              onTap: onSend,
              child: SizedBox(
                height: 18,
                width: 18,
                child: Image.asset("assets/images/send.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder customBorder() =>
      OutlineInputBorder(borderSide: BorderSide(color: Colors.white));
}
