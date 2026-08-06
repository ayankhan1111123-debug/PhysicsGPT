import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkdownMessage extends StatelessWidget {
  final String text;

  const MarkdownMessage({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      selectable: true,

      styleSheet: MarkdownStyleSheet(
        p: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16,
          height: 1.85,
        ),

        h1: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),

        h2: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),

        h3: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),

        h4: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),

        h5: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),

        h6: GoogleFonts.inter(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),

        strong: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        em: GoogleFonts.inter(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
        ),

        blockquote: GoogleFonts.inter(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
          height: 1.7,
        ),

        listBullet: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16,
        ),

        code: GoogleFonts.robotoMono(
          color: Colors.greenAccent,
          fontSize: 14,
        ),

        codeblockPadding: const EdgeInsets.all(16),

        codeblockDecoration: BoxDecoration(
          color: const Color(0xff111111),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white10,
          ),
        ),

        tableHead: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        tableBody: GoogleFonts.inter(
          color: Colors.white,
        ),

        tableBorder: TableBorder.all(
          color: Colors.white24,
          width: 1,
        ),

        tableCellsPadding: const EdgeInsets.all(12),

        horizontalRuleDecoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white24,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}