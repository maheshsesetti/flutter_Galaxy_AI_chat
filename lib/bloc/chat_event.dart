// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent {}

class ChatGenerateTextEvent extends ChatEvent {
  final String message;
  ChatGenerateTextEvent({
    required this.message,
  });

}
