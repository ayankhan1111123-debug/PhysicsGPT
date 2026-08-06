import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/design/app_spacing.dart';
import '../../../core/theme/theme_provider.dart';
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
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,

          title: const Text(
            "PhysicsGPT",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          actions: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  tooltip: "Toggle Theme",
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () async {
                    await themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppSpacing.screenPadding,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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