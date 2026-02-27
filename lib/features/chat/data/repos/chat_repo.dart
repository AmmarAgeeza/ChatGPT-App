import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<String, ChatMessage>> getChatResponse(
    List<ChatMessage> messages,
  );
}