import 'dart:io';

import '../agents/derivation_agent.dart';
import '../agents/numerical_agent.dart';
import '../agents/physics_agent.dart';

import 'ai_service.dart';
import 'gemini_service.dart';
import 'openrouter_service.dart';

class AIManager {
  AIManager._();

  static final AIManager instance = AIManager._();

  final AIService _gemini = GeminiService();
  final AIService _openRouter = OpenRouterService();

  String _systemPrompt(String prompt) {
    final text = prompt.toLowerCase();

    if (text.contains("derive") ||
        text.contains("derivation") ||
        text.contains("prove")) {
      return DerivationAgent.systemPrompt;
    }

    if (text.contains("calculate") ||
        text.contains("solve") ||
        text.contains("find") ||
        text.contains("numerical")) {
      return NumericalAgent.systemPrompt;
    }

    return PhysicsAgent.systemPrompt;
  }

  Future<String> generateText({
    required String prompt,
  }) async {
    final finalPrompt = '''
${_systemPrompt(prompt)}

----------------------------

User Question:

$prompt
''';

    try {
      return await _gemini.generateText(
        prompt: finalPrompt,
      );
    } catch (_) {
      return await _openRouter.generateText(
        prompt: finalPrompt,
      );
    }
  }

  Future<String> solveImage({
    required File image,
    required String prompt,
  }) async {
    final finalPrompt = '''
${_systemPrompt(prompt)}

----------------------------

Image Question:

$prompt
''';

    try {
      return await _openRouter.solveImage(
        image: image,
        prompt: finalPrompt,
      );
    } catch (_) {
      return await _gemini.solveImage(
        image: image,
        prompt: finalPrompt,
      );
    }
  }
}