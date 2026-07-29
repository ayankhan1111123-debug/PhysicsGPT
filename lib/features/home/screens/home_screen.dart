import 'package:flutter/material.dart';

import '../../../core/design/app_spacing.dart';
import '../widgets/continue_learning_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/recent_chats_section.dart';
import '../widgets/search_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeroSection(),

              SizedBox(height: AppSpacing.xl),

              SearchSection(),

              SizedBox(height: AppSpacing.xl),

              RecentChatsSection(),

              SizedBox(height: AppSpacing.xl),

              ContinueLearningSection(),
            ],
          ),
        ),
      ),
    );
  }
}