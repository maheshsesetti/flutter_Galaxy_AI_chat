


class ChatMessageModel {
    final String? role;
    final List<ChatPartsModel>? parts;

    ChatMessageModel({
        this.role,
        this.parts,
    });

    factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
        role: json["role"],
        parts: json["parts"] == null ? [] : List<ChatPartsModel>.from(json["parts"]!.map((x) => ChatPartsModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "parts": parts == null ? [] : List<dynamic>.from(parts!.map((x) => x.toJson())),
    };
}

class ChatPartsModel {
    final String? text;

   ChatPartsModel({
        this.text,
    });

    factory ChatPartsModel.fromJson(Map<String, dynamic> json) => ChatPartsModel(
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
    };
}