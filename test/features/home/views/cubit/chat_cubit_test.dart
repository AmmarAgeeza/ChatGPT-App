import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/home/data/models/home_model.dart';
import 'package:chatgpt_app/features/home/data/repos/home_repo.dart';
import 'package:chatgpt_app/features/home/views/cubit/chat_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class MockHomeRepo extends HomeRepo {
  bool shouldReturnOfflineFailure = false;

  @override
  Future<Either<String, HomeModel>> getResponse(String text) async {
    if (shouldReturnOfflineFailure) {
      return const Left("No Internet Connection");
    }
    if (text == "error") {
      return const Left("Server Error");
    }
    return const Right(HomeModel(text: "Response from AI"));
  }
}

void main() {
  late ChatCubit chatCubit;
  late MockHomeRepo mockHomeRepo;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    chatCubit = ChatCubit(mockHomeRepo);
  });

  group('ChatCubit', () {
    test('initial state is ChatInitial', () {
      expect(chatCubit.state, isA<ChatInitial>());
      expect(chatCubit.messages, isEmpty);
    });

    test(
      'sendMessage emits [ChatSuccess, ChatLoading, ChatSuccess] on success',
      () async {
        final expectedStates = [
          isA<ChatSuccess>(),
          isA<ChatLoading>(),
          isA<ChatSuccess>(),
        ];

        expectLater(chatCubit.stream, emitsInOrder(expectedStates));

        chatCubit.sendMessage("Hello");
      },
    );

    test('sendMessage updates messages list correctly', () async {
      chatCubit.sendMessage("Hello");

      // Allow async operations to complete
      await Future.delayed(const Duration(milliseconds: 50));

      expect(chatCubit.messages.length, 2);
      // messages[0] is most recent (AI)
      expect(chatCubit.messages[0].isUser, false);
      expect(chatCubit.messages[0].text, "Response from AI");

      // messages[1] is user message
      expect(chatCubit.messages[1].isUser, true);
      expect(chatCubit.messages[1].text, "Hello");
      expect(chatCubit.messages[1].status, MessageStatus.success);
    });

    test('sendMessage sets status to error on failure', () async {
      chatCubit.sendMessage("error");
      await Future.delayed(const Duration(milliseconds: 50));

      expect(chatCubit.messages.length, 1);
      expect(chatCubit.messages[0].status, MessageStatus.error);
    });

    test(
      'sendMessage sets status to error on No Internet Connection',
      () async {
        mockHomeRepo.shouldReturnOfflineFailure = true;
        chatCubit.sendMessage("Hello");
        await Future.delayed(const Duration(milliseconds: 50));

        expect(chatCubit.messages.length, 1);
        expect(chatCubit.messages[0].status, MessageStatus.error);
      },
    );

    test('retry resends the message', () async {
      chatCubit.sendMessage("error");
      await Future.delayed(const Duration(milliseconds: 50));
      expect(chatCubit.messages[0].status, MessageStatus.error);

      // Expect sequence:
      // 1. ChatSuccess (from retry remove)
      // 2. ChatSuccess (from sendMessage insert)
      // 3. ChatLoading
      // 4. ChatFailure (since mock still fails for "error")
      final expectedStates = [
        isA<ChatSuccess>(),
        isA<ChatLoading>(),
        isA<ChatFailure>(),
      ];

      expectLater(chatCubit.stream, emitsInOrder(expectedStates));
      chatCubit.retry(0);
    });

    test(
      'sendMessage emits [ChatSuccess, ChatLoading, ChatFailure] on error',
      () async {
        expectLater(
          chatCubit.stream,
          emitsInOrder([
            isA<ChatSuccess>(),
            isA<ChatLoading>(),
            isA<ChatFailure>(),
          ]),
        );

        chatCubit.sendMessage("error");
      },
    );
  });
}
