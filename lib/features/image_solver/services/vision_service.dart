import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VisionService {
  final String apiKey = dotenv.env['GEMINI_API_KEY']!;

  Future<String> solvePhysicsImage({
    required File image,
    String prompt = """
You are PhysicsGPT.

The user uploaded an image.

If it contains a physics question:

1. Read the entire question.
2. Extract all values.
3. Identify what is being asked.
4. Explain every formula.
5. Solve step by step.
6. Show calculations.
7. Give the final answer.

If there are multiple questions,
solve each separately.
""",
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

    print("========== VISION ==========");
    print("Image Path:");
    print(image.path);

    print("Mime Type:");
    print(mimeType);

    print("Image Size:");
    print(await image.length());

    const model = "gemini-2.5-flash-lite";

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent",
    );

    print("MODEL USED: $model");
    print("REQUEST URL: $url");

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

    print("========== REQUEST ==========");
    print(const JsonEncoder.withIndent("  ").convert(body));

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-goog-api-key": apiKey,
      },
      body: jsonEncode(body),
    );

    print("========== RESPONSE ==========");
    print("Status Code: ${response.statusCode}");
    print(response.body);
        if (response.statusCode != 200) {
      throw Exception(
        "Gemini API Error (${response.statusCode})\n${response.body}",
      );
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (!json.containsKey("candidates")) {
      throw Exception("No candidates found.");
    }

    final candidates = json["candidates"] as List;

    if (candidates.isEmpty) {
      throw Exception("Gemini returned no candidates.");
    }

    final candidate = candidates.first;

    if (candidate["content"] == null) {
      throw Exception("No content returned by Gemini.");
    }

    final content = candidate["content"];

    if (content["parts"] == null) {
      throw Exception("No parts returned by Gemini.");
    }

    final parts = content["parts"] as List;

    if (parts.isEmpty) {
      throw Exception("Empty parts returned.");
    }

    final answer = parts.first["text"];

    if (answer == null) {
      throw Exception("Gemini did not return text.");
    }

    return answer.toString();
  }
}