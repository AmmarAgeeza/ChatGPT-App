import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';

mixin ChatRepoValidationMixin {
  String? validateInput(List<ChatMessageModel> messages) {
    if (messages.isEmpty) {
      return "Messages list cannot be empty";
    }

    if (messages.any((m) => m.displayText.trim().isEmpty)) {
      return "Message text cannot be empty";
    }

    if (messages.length > 50) {
      return "Too many messages in the conversation";
    }

    return null;
  }

  String? validateOutput(ChatMessageModel result) {
    if (result.parts.isEmpty) {
      return "No response from the server";
    }

    final text = result.parts.first.text;

    if (text.trim().isEmpty) {
      return "Server returned an empty response";
    }

    return null;
  }
}