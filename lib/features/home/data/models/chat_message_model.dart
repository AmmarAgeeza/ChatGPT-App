enum MessageStatus { sending, success, error }

class ChatMessage {
  final String text;
  final bool isUser;
  final MessageStatus status;
  final bool shouldAnimate;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.status = MessageStatus.success,
    this.shouldAnimate = false,
  });

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    MessageStatus? status,
    bool? shouldAnimate,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      status: status ?? this.status,
      shouldAnimate: shouldAnimate ?? this.shouldAnimate,
    );
  }

  Map<String, dynamic> toJson() => {
    "parts": [
      {"text": text},
    ],
    "role": isUser ? "user" : "model",
  };
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['parts'][0]['text'],
      isUser: json['role'] == "user",
      status: MessageStatus.values[json['status'] ?? 0],
    );
  }
}
