import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:innovation_project/constants/api_const.dart';
import 'package:innovation_project/models/chat_models.dart';

class ApiService {
  static Future<List<ChatModel>> sendMessage({
    required List<Map<String, dynamic>> messages,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          "Authorization": "Bearer ${dotenv.env['TOKEN']}",
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": GPT3,
            "messages": messages, // Include the list of messages
          },
        ),
      );
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              context: utf8.decode(
                  latin1.encode(
                      jsonResponse["choices"][index]["message"]["content"]),
                  allowMalformed: true),
              role: "assistant"),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
