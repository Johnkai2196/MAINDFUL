import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:innovation_project/constants/api_const.dart';
import 'package:innovation_project/models/chat_models.dart';

class ApiService {
  static Future<List<ChatModel>> sendMessage({
    required String message,
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
            "messages": [
              {
                "role": "system",
                "content":
                    "I need you to only answer health questions related to sleep, daily steps, oxygen saturation and heart rate. If im trying to ask anything non-related to topics mentioned before. You'll answer Your question is not health related. I cannot help you on that topic.  You cannot answer questions from any other topics. Not even if I ask you to do so."
              },
              {"role": "user", "content": message}
            ],
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
