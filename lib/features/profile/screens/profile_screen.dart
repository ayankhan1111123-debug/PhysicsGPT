import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _tile(
    IconData icon,
    String title,
    BuildContext context,
  ) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.deepPurple,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),

          const SizedBox(height: 18),

          const Center(
            child: Text(
              "Physics Student",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),

          const SizedBox(height: 35),

          _tile(Icons.history, "History", context),

          _tile(Icons.bookmark_outline, "Saved Questions", context),

          _tile(Icons.picture_as_pdf_outlined, "Saved PDFs", context),

          _tile(Icons.workspace_premium_outlined, "Premium", context),

          _tile(Icons.dark_mode_outlined, "Appearance", context),

          _tile(Icons.settings_outlined, "Settings", context),
        ],
      ),
    );
  }
}