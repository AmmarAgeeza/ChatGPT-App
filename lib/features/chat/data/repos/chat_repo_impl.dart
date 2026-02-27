import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../services/gemini_chat_service.dart';
import 'chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final GeminiChatService geminiChatService;

  ChatRepoImpl({required this.geminiChatService});
  @override
  Future<Either<String, ChatMessageModel>> getChatResponse(
    List<ChatMessageModel> messages,
  ) async {
    try {
      return Right(await geminiChatService.getChatResponse(messages));
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }
}
