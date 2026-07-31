import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onCamera;
  final VoidCallback? onGallery;
  final bool isLoading;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.onCamera,
    this.onGallery,
    this.isLoading = false,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: widget.onGallery,
              icon: const Icon(
                Icons.photo_library_rounded,
                color: Colors.white70,
              ),
            ),

            IconButton(
              onPressed: widget.onCamera,
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white70,
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextField(
                  controller: widget.controller,
                  minLines: 1,
                  maxLines: 6,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) {
                    if (!widget.isLoading) {
                      widget.onSend();
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Message PhysicsGPT...",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: widget.isLoading ? null : widget.onSend,
                child: SizedBox(
                  width: 52,
                  height: 52,
                  child: Center(
                    child: widget.isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : const Icon(
                            Icons.send_rounded,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}