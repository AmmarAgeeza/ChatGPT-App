part of 'ai_chat_cubit.dart';

sealed class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object> get props => [];
}

final class AiChatInitial extends AiChatState {}

final class AiChatLoading extends AiChatState {}

final class AiChatLoaded extends AiChatState {
  final ChatMessageModel chatMessage;
  const AiChatLoaded(this.chatMessage);
}

final class AiChatError extends AiChatState {
  final String errorMessage;
  const AiChatError(this.errorMessage);
}

