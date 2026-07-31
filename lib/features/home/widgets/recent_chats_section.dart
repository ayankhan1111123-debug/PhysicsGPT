import 'package:flutter/material.dart';

import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_text_styles.dart';
import '../../../core/widgets/recent_chat_card.dart';
import '../../../database/conversation.dart';
import '../../../database/conversation_repository.dart';

class RecentChatsSection extends StatelessWidget {
  const RecentChatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
      future: ConversationRepository().getConversations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final conversations = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Chats",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: AppSpacing.md),

            if (conversations.isEmpty)
              const Text(
                "No recent chats yet.",
                style: AppTextStyles.bodyMedium,
              )
            else
              ...conversations.map(
                (conversation) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                  ),
                  child: RecentChatCard(
                    title: conversation.title,
                    subtitle: conversation.updatedAt.toString(),
                    category: "Physics",
                    icon: Icons.chat_bubble_outline,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}