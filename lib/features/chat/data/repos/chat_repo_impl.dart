import 'package:chatgpt_app/core/mixins/chat_repo_validation_mixin.dart';
import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../services/gemini_chat_service.dart';
import 'chat_repo.dart';

class ChatRepoImpl extends ChatRepo with ChatRepoValidationMixin {
  final GeminiChatService geminiChatService;

  ChatRepoImpl({required this.geminiChatService});

  @override
  Future<Either<String, ChatMessageModel>> getChatResponse(
    List<ChatMessageModel> messages,
  ) async {
    /// INPUT VALIDATION
    final inputValidation = validateInput(messages);
    if (inputValidation != null) {
      return Left(inputValidation);
    }

    try {
      final result = await geminiChatService.getChatResponse(messages);

      /// OUTPUT VALIDATION
      final outputValidation = validateOutput(result);
      if (outputValidation != null) {
        return Left(outputValidation);
      }

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    } catch (_) {
      return const Left("Unexpected error occurred");
    }
  }
}
