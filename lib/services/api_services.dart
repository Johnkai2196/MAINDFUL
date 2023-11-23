// Importing necessary Dart libraries and packages
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Importing external packages for Flutter environment
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Importing constants and models from other files
import 'package:innovation_project/constants/api_const.dart';
import 'package:innovation_project/models/chat_models.dart';

// Class responsible for making API requests related to chat functionality
class ApiService {
  late bool isInitialized;
  // Asynchronous method to send messages to the chat API
  static Future sendMessage({
    required List<Map<String, dynamic>> messages,
    isInitialized = true,
  }) async {
    try {
      // Making a POST request to the chat API endpoint
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          "Authorization":
              "Bearer ${dotenv.env['TOKEN']}", // Including authorization token from environment variables
          "Content-Type": "application/json" // Specifying content type as JSON
        },
        body: jsonEncode(
          {
            "model": GPT4T, // Specifying the chat model
            "messages": messages, // Include the list of messages
            "temperature": 1.3,
            "top_p": 0.8,
            "frequency_penalty": 0.55,
            "presence_penalty": 0.4
          },
        ),
      );

      // Decoding the response body from JSON format
      Map jsonResponse = jsonDecode(response.body);

      // Checking for errors in the API response
      if (jsonResponse["error"] != null) {
        // Throwing an exception if an error is detected
        throw HttpException(jsonResponse["error"]["message"]);
      }

      if (isInitialized) {
        // Initializing an empty list to store chat messages
        List<ChatModel> chatList = [];

        // Checking if there are choices in the API response
        if (jsonResponse["choices"].length > 0) {
          // Generating a list of ChatModel objects from the choices in the response
          chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                // Creating a ChatModel instance with context and role
                context: utf8.decode(
                    latin1.encode(
                        jsonResponse["choices"][index]["message"]["content"]),
                    allowMalformed: true),
                role: "assistant"),
          );
        }

        // Returning the list of chat messages
        return chatList;
      } else {
        // Returning the list of chat messages
        return utf8.decode(
            latin1.encode(jsonResponse["choices"][0]["message"]["content"]),
            allowMalformed: true);
      }
    } catch (error) {
      // Logging and rethrowing the error if an exception occurs
      log("error $error");
      rethrow;
    }
  }
}
