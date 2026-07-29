import 'package:flutter/material.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_radius.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_text_styles.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ask anything in Physics...",
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textHint,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              _icon(Icons.camera_alt_outlined),
              const SizedBox(width: 18),

              _icon(Icons.picture_as_pdf_outlined),
              const SizedBox(width: 18),

              _icon(Icons.mic_none_rounded),

              const Spacer(),

              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Icon(
      icon,
      size: 24,
      color: AppColors.textSecondary,
    );
  }
}