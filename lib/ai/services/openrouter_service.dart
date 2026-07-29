import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/ai_provider.dart';
import 'ai_service.dart';

class OpenRouterService implements AIService {
  @override
  AIProvider get provider => AIProvider.openrouter;

  final String apiKey = dotenv.env['OPENROUTER_API_KEY']!;

  static const String _model = "google/gemini-2.5-flash";

  static const String _url =
      "https://openrouter.ai/api/v1/chat/completions";

  Map<String, String> get _headers => {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://physicsgpt.app",
        "X-Title": "PhysicsGPT",
      };

  @override
  Future<bool> isAvailable() async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: _headers,
        body: jsonEncode({
  "model": _model,
  "max_tokens": 20,
  "messages": [
            {
              "role": "user",
              "content": "Say OK",
            }
          ]
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String> generateText({
    required String prompt,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: _headers,
    body: jsonEncode({
  "model": _model,
  "max_tokens": 2000,
  "messages": [
          {
            "role": "user",
            "content": prompt,
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "OpenRouter Error (${response.statusCode})\n${response.body}",
      );
    }

    final json = jsonDecode(response.body);

    return json["choices"][0]["message"]["content"];
  }
    @override
  Future<String> solveImage({
    required File image,
    required String prompt,
  }) async {
    final bytes = await image.readAsBytes();

    final base64Image = base64Encode(bytes);

    String mimeType = "image/jpeg";

    final path = image.path.toLowerCase();

    if (path.endsWith(".png")) {
      mimeType = "image/png";
    } else if (path.endsWith(".jpg")) {
      mimeType = "image/jpeg";
    } else if (path.endsWith(".jpeg")) {
      mimeType = "image/jpeg";
    } else if (path.endsWith(".webp")) {
      mimeType = "image/webp";
    }

    final response = await http.post(
      Uri.parse(_url),
      headers: _headers,
      body: jsonEncode({
  "model": _model,
  "max_tokens": 2000,
  "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": prompt,
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "data:$mimeType;base64,$base64Image",
                }
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "OpenRouter Vision Error (${response.statusCode})\n${response.body}",
      );
    }

    final json = jsonDecode(response.body);

    return json["choices"][0]["message"]["content"];
  }
}