import 'package:chatgpt_app/core/mixins/chat_repo_validation_mixin.dart';
import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/chat/data/models/chat_message_part_model.dart';
import 'package:chatgpt_app/features/chat/data/repos/chat_repo_impl.dart';
import 'package:chatgpt_app/features/chat/data/services/gemini_chat_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ChatValidationMixinTest with ChatRepoValidationMixin {}

void main() {
  late ChatRepoImpl chatRepoImpl;
  late MockedGeminiChatService mockedGeminiChatService;
  late ChatValidationMixinTest chatValidationMixinTest;
  setUp(() {
    mockedGeminiChatService = MockedGeminiChatService();
    chatRepoImpl = ChatRepoImpl(geminiChatService: mockedGeminiChatService);
    chatValidationMixinTest = ChatValidationMixinTest();
  });
  //validate input
  group("get chat response", () {
    test("should return left when messages are empty", () async {
      expect(
        await chatRepoImpl.getChatResponse([]),
        isA<Left<String, ChatMessageModel>>(),
      );
    });

    test("should return right when service succeeds", () async {
      final responseModel = ChatMessageModel(
        role: "model",
        parts: [ChatMessagePartModel(text: "Hi there!")],
      );
      when(
        () => mockedGeminiChatService.getChatResponse(any()),
      ).thenAnswer((_) async => responseModel);

      expect(
        await chatRepoImpl.getChatResponse([
          ChatMessageModel(
            role: "user",
            parts: [ChatMessagePartModel(text: "Hello")],
          ),
        ]),
        isA<Right<String, ChatMessageModel>>(),
      );
    });
  });
  //validate output
  group("get chat response server exception", () {
    test("should return left when service returns empty parts", () async {
      when(
        () => mockedGeminiChatService.getChatResponse(any()),
      ).thenAnswer((_) async => ChatMessageModel(role: "model", parts: []));
      expect(
        await chatRepoImpl.getChatResponse([
          ChatMessageModel(
            role: "user",
            parts: [ChatMessagePartModel(text: "Hello")],
          ),
        ]),
        isA<Left<String, ChatMessageModel>>(),
      );
    });
  });

  //!after refactoring
  //we will test the mixin directly
  //we will create a class that extends the mixin to test it
  ///validate input
  group("validate input", () {
    test("should return left when messages are empty", () {
      expect(
        chatValidationMixinTest.validateInput([]),
        "Messages list cannot be empty",
      );
    });

    test("should return right when service succeeds", () {
      expect(
        chatValidationMixinTest.validateInput([
          ChatMessageModel(
            role: "user",
            parts: [ChatMessagePartModel(text: "Hello")],
          ),
        ]),
        null,
      );
    });
  });
  //validate output
  group("validate output", () {
    test("should return left when service returns empty parts", () {
      expect(
        chatValidationMixinTest.validateOutput(
          ChatMessageModel(role: "model", parts: []),
        ),
        isA<String>(),
      );
    });

    test("should return right when service succeeds", () {
      expect(
        chatValidationMixinTest.validateOutput(
          ChatMessageModel(
            role: "model",
            parts: [ChatMessagePartModel(text: "Hi there!")],
          ),
        ),
        null,
      );
    });
  });
}

class MockedGeminiChatService extends Mock implements GeminiChatService {}
