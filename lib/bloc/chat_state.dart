// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';


sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatMessageSuccess extends ChatState {
  final List<ChatMessageModel> message;
  ChatMessageSuccess({
    required this.message,
  });

}
