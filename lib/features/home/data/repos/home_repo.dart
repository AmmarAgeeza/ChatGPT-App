import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/api/api_consumer.dart';
import '../../../../core/database/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/service_locator.dart';

class HomeRepo {
  Future<Either<String, ChatMessage>> getChatResponse(
    List<ChatMessage> messages,
  ) async {
    try {
      final res = await sl<ApiConsumer>().post(
        EndPoints.generateContent,
        body: {"contents": messages.map((e) => e.toJson()).toList()},
      );
      return Right(ChatMessage.fromJson(res["candidates"][0]["content"]));
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }
}
