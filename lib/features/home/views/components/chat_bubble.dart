import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRetry;

  const ChatBuble({super.key, required this.message, this.onRetry});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (message.status == MessageStatus.error) ...[
              const SizedBox(height: 5),
              GestureDetector(
                onTap: onRetry,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.refresh, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "Retry",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
