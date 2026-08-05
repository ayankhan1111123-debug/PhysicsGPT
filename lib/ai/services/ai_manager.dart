import 'dart:io';

import '../agents/physics_agent.dart';
import '../agents/numerical_agent.dart';
import '../agents/derivation_agent.dart';

import 'ai_service.dart';
import 'gemini_service.dart';
import 'openrouter_service.dart';

class AIManager {
  AIManager._();

  static final AIManager instance = AIManager._();

  final AIService _gemini = GeminiService();
  final AIService _openRouter = OpenRouterService();

  String _selectPrompt(String question) {
    final q = question.toLowerCase();

    // Derivation Agent
    if (q.contains('derive') ||
        q.contains('derivation') ||
        q.contains('prove')) {
      return DerivationAgent.systemPrompt;
    }

    // Numerical Agent
    if (q.contains('solve') ||
        q.contains('calculate') ||
        q.contains('find') ||
        q.contains('numerical')) {
      return NumericalAgent.systemPrompt;
    }

    // Default Physics Tutor
    return PhysicsAgent.systemPrompt;
  }

  Future<String> generateText({
    required String prompt,
  }) async {
    final fullPrompt = '''
${_selectPrompt(prompt)}

User Question:

$prompt
''';

    try {
      return await _gemini.generateText(
        prompt: fullPrompt,
      );
    } catch (_) {
      return await _openRouter.generateText(
        prompt: fullPrompt,
      );
    }
  }

  Future<String> solveImage({
    required File image,
    required String prompt,
  }) async {
    final fullPrompt = '''
${PhysicsAgent.systemPrompt}

The user has uploaded a Physics image.

Instructions:
- Read all visible text.
- Identify the topic.
- Solve every question step by step.
- Explain formulas used.
- Use Markdown formatting.

User Prompt:

$prompt
''';

    try {
      return await _openRouter.solveImage(
        image: image,
        prompt: fullPrompt,
      );
    } catch (_) {
      return await _gemini.solveImage(
        image: image,
        prompt: fullPrompt,
      );
    }
  }
}