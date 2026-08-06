import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/widgets/markdown_message.dart';
import '../models/chat_message.dart';

import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  bool get isUser => message.role == MessageRole.user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          if (!isUser) _assistantAvatar(),

          if (!isUser)
            const SizedBox(width: 12),

          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color(0xff2B2B2B)
                    : const Color(0xff171717),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(22),
                  topRight: const Radius.circular(22),
                  bottomLeft: Radius.circular(
                    isUser ? 22 : 6,
                  ),
                  bottomRight: Radius.circular(
                    isUser ? 6 : 22,
                  ),
                ),
                border: Border.all(
                  color: Colors.white10,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  if (message.type == MessageType.text)
                    _buildMarkdown(),

                  if (message.type == MessageType.image)
                    _buildImage(),

                  if (message.type == MessageType.pdf)
                    _buildPdf(),

                  const SizedBox(height: 14),

                  Row(
                    children: [

                      Text(
                        _formatTime(
                          message.timestamp,
                        ),
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        splashRadius: 18,
                        icon: const Icon(
                          Icons.copy_rounded,
                          color: Colors.white54,
                          size: 18,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text: message.content,
                            ),
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text("Copied"),
                              ),
                            );
                          }
                        },
                      ),

                      IconButton(
                        splashRadius: 18,
                        icon: const Icon(
                          Icons.share_rounded,
                          color: Colors.white54,
                          size: 18,
                        ),
                        onPressed: () {
                          Share.share(message.content);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (isUser)
            const SizedBox(width: 12),

          if (isUser)
            _userAvatar(),
        ],
      ),
    );
  }

  Widget _assistantAvatar() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.auto_awesome,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget _userAvatar() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Color(0xff2D2D2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }
    Widget _buildImage() {
    if (message.imageFile == null) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.image_outlined,
          color: Colors.white,
          size: 50,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(message.imageFile!.path),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          message.content,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildPdf() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.picture_as_pdf_rounded,
            color: Colors.redAccent,
            size: 42,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              message.pdfName ?? "Physics Notes.pdf",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildMarkdown() {
  final regex = RegExp(
    r'\$\$(.*?)\$\$',
    dotAll: true,
  );

  if (regex.hasMatch(message.content)) {
    final latex =
        regex.firstMatch(message.content)!.group(1)!;

    return Math.tex(
      latex,
      textStyle: GoogleFonts.inter(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }

  return MarkdownMessage(
    text: message.content,
  );
}

    

  String _formatTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }
}