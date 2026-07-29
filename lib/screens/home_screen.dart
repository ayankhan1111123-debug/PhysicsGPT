import 'package:flutter/material.dart';

import '../core/theme/theme_provider.dart';
import '../features/chat/screens/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final ThemeProvider themeProvider;

  const HomeScreen({
    super.key,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PhysicsGPT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Toggle Theme",
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              Text(
                "Good Morning 👋",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Solve any Physics\nproblem instantly.",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 28),

              _menuCard(
                context,
                Icons.camera_alt_outlined,
                "Scan Question",
                null,
              ),

              const SizedBox(height: 14),

              _menuCard(
                context,
                Icons.edit_note,
                "Type Question",
                const ChatScreen(),
              ),

              const SizedBox(height: 14),

              _menuCard(
                context,
                Icons.picture_as_pdf_outlined,
                "Upload PDF",
                null,
              ),

              const SizedBox(height: 14),

              _menuCard(
                context,
                Icons.image_outlined,
                "Images",
                null,
              ),

              const SizedBox(height: 14),

              _menuCard(
                context,
                Icons.history,
                "Recent Chats",
                null,
              ),

              const SizedBox(height: 30),

              const Text(
                "Recent",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text("📄 Projectile Motion"),
              const SizedBox(height: 12),

              const Text("📄 Newton's Laws"),
              const SizedBox(height: 12),

              const Text("📄 Thermodynamics"),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _menuCard(
    BuildContext context,
    IconData icon,
    String title,
    Widget? page,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        }
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 20,
          ),
          child: Row(
            children: [
              Icon(icon, size: 28),

              const SizedBox(width: 18),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}