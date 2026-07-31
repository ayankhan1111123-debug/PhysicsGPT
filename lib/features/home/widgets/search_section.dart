import 'package:flutter/material.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_radius.dart';
import '../../../core/design/app_spacing.dart';
import '../../chat/screens/chat_screen.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendQuestion() {
    final question = _controller.text.trim();

    if (question.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          initialPrompt: question,
        ),
      ),
    );

    _controller.clear();
  }

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
        children: [
          TextField(
            controller: _controller,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            minLines: 1,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "Ask anything in Physics...",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              _buildIcon(Icons.camera_alt_outlined),

              const SizedBox(width: 18),

              _buildIcon(Icons.picture_as_pdf_outlined),

              const SizedBox(width: 18),

              _buildIcon(Icons.mic_none_rounded),

              const Spacer(),

              GestureDetector(
                onTap: _sendQuestion,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 24,
      color: AppColors.textSecondary,
    );
  }
}