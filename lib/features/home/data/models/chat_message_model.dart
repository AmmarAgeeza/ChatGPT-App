enum MessageStatus { sending, success, error }

class ChatMessage {
  final String text;
  final bool isUser;
  final MessageStatus status;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.status = MessageStatus.success,
  });

  ChatMessage copyWith({String? text, bool? isUser, MessageStatus? status}) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'isUser': isUser, 'status': status.index};
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      isUser: json['isUser'],
      status: MessageStatus.values[json['status'] ?? 0],
    );
  }
}
