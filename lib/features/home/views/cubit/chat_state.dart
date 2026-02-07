part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {}

final class ChatFailure extends ChatState {}

final class ChatLoading extends ChatState {}
