import 'package:flutter/material.dart';

import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_text_styles.dart';
import '../../../core/widgets/recent_chat_card.dart';

class RecentChatsSection extends StatelessWidget {
  const RecentChatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Chats",
          style: AppTextStyles.heading2,
        ),

        const SizedBox(height: AppSpacing.md),

        const RecentChatCard(
          title: "Projectile Motion",
          subtitle: "2 minutes ago",
          category: "Mechanics",
          icon: Icons.rocket_launch_outlined,
        ),

        const SizedBox(height: AppSpacing.md),

        const RecentChatCard(
          title: "Newton's Laws",
          subtitle: "Yesterday",
          category: "Mechanics",
          icon: Icons.science_outlined,
        ),

        const SizedBox(height: AppSpacing.md),

        const RecentChatCard(
          title: "Electromagnetism",
          subtitle: "3 days ago",
          category: "Electricity",
          icon: Icons.bolt_outlined,
        ),
      ],
    );
  }
}