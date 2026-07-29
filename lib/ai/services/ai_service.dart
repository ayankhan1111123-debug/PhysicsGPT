import 'dart:io';

import '../models/ai_provider.dart';

abstract class AIService {
  AIProvider get provider;

  Future<String> generateText({
    required String prompt,
  });

  Future<String> solveImage({
    required File image,
    required String prompt,
  });

  Future<bool> isAvailable();
}