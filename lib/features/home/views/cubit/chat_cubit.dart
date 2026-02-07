import 'package:chatgpt_app/features/home/data/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.repo) : super(ChatInitial());
  final HomeRepo repo;

  List<String> messagesFromMe = [];
  List<String> messagesFromAI = [];
  void getResponse(String text) async {
    emit(ChatLoading());
    var result = await repo.getResponse(text);
    result.fold((error) => emit(ChatFailure()), (response) {
      messagesFromAI.add(response.text);
      emit(ChatSuccess());
    });
  }
}
