import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../image_solver/services/image_service.dart';


import '../models/chat_message.dart';
import '../services/gemini_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/message_input.dart';
import '../widgets/typing_indicator.dart';
import '../../../ai/services/ai_manager.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AIManager _aiManager = AIManager.instance;

  final ImageService _imageService = ImageService();

  final TextEditingController _controller =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  final List<ChatMessage> _messages = [];

  final Uuid _uuid = const Uuid();

  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _pickCameraImage() async {
    final File? image =
        await _imageService.pickFromCamera();

    if (image == null) return;

    final imageMessage = ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.user,
      type: MessageType.image,
      content: "Captured Image",
      imageFile: image,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(imageMessage);
    });

    _scrollToBottom();

    await _solveImage(image);
  }

  Future<void> _pickGalleryImage() async {
    final File? image =
        await _imageService.pickFromGallery();
            if (image == null) return;

    final imageMessage = ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.user,
      type: MessageType.image,
      content: "Selected Image",
      imageFile: image,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(imageMessage);
    });

    _scrollToBottom();

    await _solveImage(image);
  }

  Future<void> _solveImage(File image) async {
    print("===== SOLVING IMAGE =====");
    print(image.path);
    print(await image.length());

    setState(() {
      _isLoading = true;
    });

    try {
      final answer = await _aiManager.solveImage(
  image: image,
  prompt:
      "Solve this physics question step by step. Explain every formula used and provide the final answer.",
);

      final aiMessage = ChatMessage(
        id: _uuid.v4(),
        role: MessageRole.assistant,
        type: MessageType.text,
        content: answer,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(aiMessage);
      });
    } catch (e) {
      final errorMessage = ChatMessage(
        id: _uuid.v4(),
        role: MessageRole.assistant,
        type: MessageType.text,
        content: "Error:\n\n$e",
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(errorMessage);
      });
    }

    setState(() {
      _isLoading = false;
    });

    _scrollToBottom();
  }

  Future<void> _sendMessage() async {
    final question = _controller.text.trim();

    if (question.isEmpty) return;

    final userMessage = ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.user,
            type: MessageType.text,
      content: question,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    _controller.clear();

    _scrollToBottom();

    try {
      final reply = await _aiManager.generateText(
  prompt: question,
);

      final aiMessage = ChatMessage(
        id: _uuid.v4(),
        role: MessageRole.assistant,
        type: MessageType.text,
        content: reply,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(aiMessage);
      });
    } catch (e) {
      final errorMessage = ChatMessage(
        id: _uuid.v4(),
        role: MessageRole.assistant,
        type: MessageType.text,
        content: "Error:\n\n$e",
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(errorMessage);
      });
    }

    setState(() {
      _isLoading = false;
    });

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              "PhysicsGPT",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
            body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcomeScreen()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                    itemCount: _messages.length +
                        (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_isLoading &&
                          index == _messages.length) {
                        return const TypingIndicator();
                      }

                      return ChatBubble(
                        message: _messages[index],
                      );
                    },
                  ),
          ),

          MessageInput(
            controller: _controller,
            isLoading: _isLoading,
            onSend: _sendMessage,
            onCamera: _pickCameraImage,
            onGallery: _pickGalleryImage,
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Welcome to PhysicsGPT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Your AI Physics Assistant",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 35),
                        _featureCard(
              Icons.calculate_outlined,
              "Solve Physics Numericals",
              "Step-by-step AI solutions",
            ),

            _featureCard(
              Icons.functions,
              "Derivations & Formulae",
              "Understand every equation",
            ),

            _featureCard(
              Icons.photo_camera_outlined,
              "Image Solver",
              "Take a picture of any Physics question",
            ),

            _featureCard(
              Icons.picture_as_pdf_outlined,
              "PDF Solver",
              "Upload complete Physics notes",
            ),

            const SizedBox(height: 30),

            const Text(
              "Start by asking any Physics question below.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor:
                Colors.blue.withValues(alpha: 0.1),
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}