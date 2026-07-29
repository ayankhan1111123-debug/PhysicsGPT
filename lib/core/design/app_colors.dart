import 'package:flutter/material.dart';

/// Centralized color palette for PhysicsGPT.
/// Every color used in the app should come from this class.
class AppColors {
  AppColors._();

  // ===========================
  // Brand Colors
  // ===========================

  static const Color primary = Color(0xFF8B5CF6);
  static const Color secondary = Color(0xFFA855F7);

  // ===========================
  // Backgrounds
  // ===========================

  static const Color background = Color(0xFF09090B);
  static const Color surface = Color(0xFF18181B);
  static const Color card = Color(0xFF1F1F23);

  // ===========================
  // Text
  // ===========================

  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textHint = Color(0xFF71717A);

  // ===========================
  // Borders & Dividers
  // ===========================

  static const Color border = Color(0xFF27272A);
  static const Color divider = Color(0xFF3F3F46);

  // ===========================
  // Status
  // ===========================

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}