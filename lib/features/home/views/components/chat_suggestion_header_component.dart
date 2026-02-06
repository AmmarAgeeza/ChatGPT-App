import 'package:flutter/material.dart';

class ChatSuggetionHeaderComponent extends StatelessWidget {
  const ChatSuggetionHeaderComponent({
    super.key,
    required this.image,
    required this.title,
  });
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //image
        Image.asset(image),
        //title
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
