class ChatModel {
  final String context;
  final String role;

  ChatModel({required this.context, required this.role});
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        context: json["context"],
        role: json["role"],
      );
}
