import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_lite/model/chat_model.dart';
import 'package:galaxy_lite/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<ChatMessageModel> message = [];

  bool isGenerated = false;
  ChatBloc() : super(ChatMessageSuccess(message: const [])) {
    on<ChatGenerateTextEvent>(chatGenerateTextEvent);
  }

  FutureOr<void> chatGenerateTextEvent(
      ChatGenerateTextEvent event, Emitter<ChatState> emit) async {
    message.add(ChatMessageModel(
        role: "user", parts: [ChatPartsModel(text: event.message)]));
    isGenerated = true;
    emit(ChatMessageSuccess(message: message));
    String generatedText = await ChatRepoImpl().chatTextGenerateRepo(message);
    if (generatedText.isNotEmpty) {
      message.add(ChatMessageModel(
          role: "model", parts: [ChatPartsModel(text: generatedText)]));
      emit(ChatMessageSuccess(message: message));
    }
    isGenerated = false;
  }
}
