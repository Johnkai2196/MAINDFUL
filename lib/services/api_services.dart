// ignore_for_file: avoid_print

import 'dart:convert';
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
        //log("jsonResponse[choices]text: ${jsonResponse["choices"][0]["message"]["content"]}");

        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["message"]["content"],
              sender: false),
        );
      }

      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }
}
