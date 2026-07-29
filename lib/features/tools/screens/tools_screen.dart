import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      ("Image Solver", Icons.camera_alt_outlined),
      ("PDF Solver", Icons.picture_as_pdf_outlined),
      ("Graph Plotter", Icons.show_chart),
      ("Calculator", Icons.calculate_outlined),
      ("Formulae", Icons.functions),
      ("Unit Converter", Icons.straighten),
      ("History", Icons.history),
      ("Saved", Icons.bookmark_border),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Tools",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: GridView.builder(
          itemCount: tools.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: .95,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tools[index].$2,
                      size: 38,
                      color: Colors.deepPurple,
                    ),

                    const SizedBox(height: 18),

                    Text(
                      tools[index].$1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}