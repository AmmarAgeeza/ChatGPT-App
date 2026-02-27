import 'package:chatgpt_app/core/database/api/api_consumer.dart';
import 'package:chatgpt_app/core/database/api/end_points.dart';
import 'package:chatgpt_app/core/services/service_locator.dart';
import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';

class GeminiChatService {
  Future<ChatMessage> getChatResponse(List<ChatMessage> messages) async {
    final res = await sl<ApiConsumer>().post(
      EndPoints.generateContent,
      body: {"contents": messages.map((e) => e.toJson()).toList()},
    );
    return ChatMessage.fromJson(res["candidates"][0]["content"]);
  }
}
