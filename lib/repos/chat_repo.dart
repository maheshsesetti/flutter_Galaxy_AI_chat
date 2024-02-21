import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:galaxy_lite/model/chat_model.dart';
import 'package:galaxy_lite/model/chat_response_model.dart';

abstract class ChatRepo {
  Future<String> chatTextGenerateRepo(List<ChatMessageModel> previousMessage);
}

class ChatRepoImpl extends ChatRepo {
  ChatResponseModel? model;
  @override
  Future<String> chatTextGenerateRepo(
      List<ChatMessageModel> previousMessage) async {
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=AIzaSyBr6no7nXYm7xL6Iec1hiMCcWYcuigJhr8";
    try {
      Dio dio = Dio();
      await dio.post(url, data: {
        "contents": previousMessage.map((e) => e.toJson()).toList(),
        "generationConfig": {
          "temperature": 0.9,
          "topK": 1,
          "topP": 1,
          "maxOutputTokens": 2048,
          "stopSequences": []
        },
        "safetySettings": [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          }
        ]
      }).then((value) {
        model = ChatResponseModel.fromJson(value.data);
        
      });
      return "${model?.candidates?.first.content?.parts?.first.text}";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }
}
