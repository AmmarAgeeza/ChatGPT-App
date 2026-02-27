import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<String, ChatMessageModel>> getChatResponse(
    List<ChatMessageModel> messages,
  );
}