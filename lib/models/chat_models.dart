class ChatModel {
  final String msg;
  final bool sender;

  ChatModel({required this.msg, required this.sender});
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["msg"],
        sender: json["sender"],
      );
}
