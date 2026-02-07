import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends HydratedCubit<ChatState> {
  ChatCubit(this.repo) : super(ChatInitial());
  final HomeRepo repo;

  List<ChatMessage> messages = [];

  void sendMessage(String text) async {
    if (text.isEmpty) return;

    var userMessage = ChatMessage(
      text: text,
      isUser: true,
      status: MessageStatus.sending,
    );
    messages.insert(0, userMessage);
    emit(ChatSuccess());

    emit(ChatLoading());
    var result = await repo.getResponse(text);
    if (isClosed) return;

    // Find message index in case list changed
    var index = messages.indexOf(userMessage);

    result.fold(
      (error) {
        if (index != -1) {
          messages[index] = userMessage.copyWith(status: MessageStatus.error);
        }
        emit(ChatFailure(errorMessage: error));
      },
      (response) {
        if (index != -1) {
          messages[index] = userMessage.copyWith(status: MessageStatus.success);
        }
        messages.insert(0, ChatMessage(text: response.text, isUser: false));
        emit(ChatSuccess());
      },
    );
  }

  void retry(int index) {
    if (index >= 0 && index < messages.length) {
      var message = messages[index];
      messages.removeAt(index);
      emit(ChatSuccess());
      sendMessage(message.text);
    }
  }

  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['messages'] != null) {
        messages = (json['messages'] as List)
            .map((e) => ChatMessage.fromJson(e))
            .toList();
      }
      return ChatSuccess();
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ChatState state) {
    return {'messages': messages.map((e) => e.toJson()).toList()};
  }
}
