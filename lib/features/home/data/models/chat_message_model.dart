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
}
