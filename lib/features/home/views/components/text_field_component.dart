// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatgpt_app/features/home/views/cubit/chat_cubit.dart';

class TextFieldComponent extends StatefulWidget {
  const TextFieldComponent({super.key, this.isSugget = false});

  final bool isSugget;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: widget.isSugget
            ? "Hello chatGPT,how are you today?"
            : "Write your message",
        hintStyle: widget.isSugget
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
              onTap: () {
                if (controller.text.isNotEmpty) {
                  var text = controller.text.trim();
                  context.read<ChatCubit>().getResponse(text);
                }
              },
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
