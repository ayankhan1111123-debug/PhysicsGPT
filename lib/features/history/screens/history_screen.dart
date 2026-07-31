import 'package:flutter/material.dart';
import '../../../database/conversation.dart';
import '../../../database/conversation_repository.dart';
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ConversationRepository _repository = ConversationRepository();

  late Future<List<Conversation>> _conversations;

  @override
  void initState() {
    super.initState();
    _conversations = _repository.getConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search conversations...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon:
                    const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xff1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
         Expanded(
  child: FutureBuilder<List<Conversation>>(
    future: _conversations,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Text(
            "No conversations yet",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
        );
      }

      final chats = snapshot.data!;

      return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xff1A1A1A),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
            ),
            title: Text(
              chat.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
            trailing: Text(
              "${chat.updatedAt.hour}:${chat.updatedAt.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
            

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}