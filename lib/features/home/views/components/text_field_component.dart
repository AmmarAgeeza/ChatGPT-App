import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    super.key,
    required this.controller,
    this.isSugget = false,
  });
  final TextEditingController controller;
  final bool isSugget;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: isSugget
            ? "Hello chatGPT,how are you today?"
            : "Write your message",
        hintStyle: isSugget
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
              onTap: () {},
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
