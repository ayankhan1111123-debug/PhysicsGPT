import 'dart:io';

import 'ai_service.dart';
import 'gemini_service.dart';
import 'openrouter_service.dart';

class AIManager {
  AIManager._();

  static final AIManager instance = AIManager._();

  final AIService _gemini = GeminiService();
  final AIService _openRouter = OpenRouterService();

  Future<String> generateText({
    required String prompt,
  }) async {
    try {
      return await _gemini.generateText(
        prompt: prompt,
      );
    } catch (_) {
      return await _openRouter.generateText(
        prompt: prompt,
      );
    }
  }

  Future<String> solveImage({
    required File image,
    required String prompt,
  }) async {
      try {
              return await _openRouter.solveImage(
        image: image,
        prompt: prompt,
      );
    } catch (_) {
      return await _gemini.solveImage(
        image: image,
        prompt: prompt,
      );
    }
  }
}