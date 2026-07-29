import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          if (!isUser) _assistantAvatar(),

          if (!isUser) const SizedBox(width: 10),

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  if (message.type ==
                      MessageType.text)
                    _buildMarkdown(theme),

                  if (message.type ==
                      MessageType.image)
                    _buildImage(),

                  if (message.type ==
                      MessageType.pdf)
                    _buildPdf(),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Text(
                        _formatTime(
                          message.timestamp,
                        ),
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              Colors.grey.shade500,
                        ),
                      ),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.copy,
                              size: 18,
                            ),
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(
                                  text: message.content,
                                ),
                              );

                              if (context
                                  .mounted) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Copied",
                                    ),
                                  ),
                                );
                              }
                            },
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.share,
                              size: 18,
                            ),
                            onPressed: () {
                              Share.share(
                                message.content,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (isUser)
            const SizedBox(width: 10),

          if (isUser) _userAvatar(),
        ],
      ),
    );
  }

  Widget _assistantAvatar() {
    return const CircleAvatar(
      radius: 18,
      child: Icon(Icons.smart_toy),
    );
  }

  Widget _userAvatar() {
    return const CircleAvatar(
      radius: 18,
      child: Icon(Icons.person),
    );
  }
    Widget _buildImage() {
    if (message.imageFile == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.image,
            size: 60,
          ),
          const SizedBox(height: 8),
          Text(message.content),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(message.imageFile!.path),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message.content,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPdf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.picture_as_pdf,
          size: 60,
        ),
        const SizedBox(height: 8),
        Text(
          message.pdfName ?? "PDF",
        ),
      ],
    );
  }

  Widget _buildMarkdown(
    ThemeData theme,
  ) {
    final regex = RegExp(
      r'\$\$(.*?)\$\$',
      dotAll: true,
    );

    if (regex.hasMatch(message.content)) {
      final latex =
          regex.firstMatch(message.content)!
              .group(1)!;

      return Math.tex(
        latex,
        textStyle: GoogleFonts.inter(
          fontSize: 18,
          color: isUser
              ? Colors.white
              : theme.colorScheme.onSurface,
        ),
      );
    }

    return MarkdownBody(
      selectable: true,
      data: message.content,
      styleSheet: MarkdownStyleSheet(
        p: GoogleFonts.inter(
          fontSize: 16,
          color: isUser
              ? Colors.white
              : theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  String _formatTime(
    DateTime date,
  ) {
    final h =
        date.hour.toString().padLeft(2, '0');

    final m =
        date.minute.toString().padLeft(2, '0');

    return "$h:$m";
  }
}