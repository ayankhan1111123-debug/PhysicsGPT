import 'package:flutter/material.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_text_styles.dart';
import '../../../core/widgets/physics_card.dart';
import '../../../core/widgets/section_header.dart';

class ContinueLearningSection extends StatelessWidget {
  const ContinueLearningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: "Continue Learning",
        ),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              LearningCard(
                title: "Kinematics",
                progress: 0.72,
                icon: Icons.timeline,
              ),

              SizedBox(width: AppSpacing.md),

              LearningCard(
                title: "Electromagnetism",
                progress: 0.48,
                icon: Icons.bolt,
              ),

              SizedBox(width: AppSpacing.md),

              LearningCard(
                title: "Thermodynamics",
                progress: 0.31,
                icon: Icons.local_fire_department,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LearningCard extends StatelessWidget {
  final String title;
  final double progress;
  final IconData icon;

  const LearningCard({
    super.key,
    required this.title,
    required this.progress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return SizedBox(
      width: 240,
      child: PhysicsCard(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 34,
                color: Colors.white,
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                title,
                style: AppTextStyles.heading3,
              ),

              const SizedBox(height: 6),

              Text(
                "$percent% Complete",
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const Spacer(),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}