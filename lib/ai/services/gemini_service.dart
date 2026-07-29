import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/ai_provider.dart';
import 'ai_service.dart';

class GeminiService implements AIService {
  @override
  AIProvider get provider => AIProvider.gemini;

  final String apiKey = dotenv.env['GEMINI_API_KEY']!;

 static const String _model = "gemini-2.5-flash-lite";

  Uri get _url => Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent",
      );

  Map<String, String> get _headers => {
        "Content-Type": "application/json",
        "x-goog-api-key": apiKey,
      };

  @override
  Future<bool> isAvailable() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey",
        ),
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
    final body = {
      "contents": [
        {
          "parts": [
            {
              "text": prompt,
            }
          ]
        }
      ]
    };

    final response = await http.post(
      _url,
      headers: _headers,
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Gemini Error (${response.statusCode})\n${response.body}",
      );
    }

    final json = jsonDecode(response.body);

    return json["candidates"][0]["content"]["parts"][0]["text"];
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

    final body = {
      "contents": [
        {
          "parts": [
            {
              "inlineData": {
                "mimeType": mimeType,
                "data": base64Image,
              }
            },
            {
              "text": prompt,
            }
          ]
        }
      ]
    };

    final response = await http.post(
      _url,
      headers: _headers,
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Gemini Vision Error (${response.statusCode})\n${response.body}",
      );
    }

    final json = jsonDecode(response.body);

    if (json["candidates"] == null) {
      throw Exception("No candidates returned.");
    }

    final candidates = json["candidates"] as List;

    if (candidates.isEmpty) {
      throw Exception("Empty candidates.");
    }

    final parts = candidates.first["content"]["parts"] as List;

    if (parts.isEmpty) {
      throw Exception("Empty response.");
    }

    return parts.first["text"].toString();
  }
}