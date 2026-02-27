import 'package:chatgpt_app/features/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_app/features/chat/data/repos/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final ChatRepo chatRepo;
  AiChatCubit({required this.chatRepo}) : super(AiChatInitial());
  Future<void> getChatResponse(List<ChatMessageModel> messages) async {
    emit(AiChatLoading());
    final result = await chatRepo.getChatResponse(messages);
    result.fold(
      (failure) => emit(AiChatError(failure)),
      (chatMessage) => emit(AiChatLoaded(chatMessage)),
    );
  }
}
