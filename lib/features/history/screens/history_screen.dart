import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../chat/screens/chat_screen.dart';
import '../../../database/conversation.dart';
import '../../../database/conversation_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ConversationRepository _repository = ConversationRepository();

  List<Conversation> _allChats = [];
  List<Conversation> _filteredChats = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    final chats = await _repository.getConversations();

    setState(() {
      _allChats = chats;
      _filteredChats = chats;
      _loading = false;
    });
  }

  void _search(String value) {
    setState(() {
      if (value.isEmpty) {
        _filteredChats = _allChats;
      } else {
        _filteredChats = _allChats.where((chat) {
          return chat.title
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              chat.lastMessage
                  .toLowerCase()
                  .contains(value.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _deleteChat(Conversation chat) async {
    if (chat.id != null) {
      await _repository.deleteConversation(chat.id!);
    }

    await _loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pop(context),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: _search,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search conversations...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                filled: true,
                fillColor: const Color(0xff1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _filteredChats.isEmpty
                    ? const Center(
                        child: Text(
                          "No conversations yet",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredChats.length,
                        itemBuilder: (context, index) {
                          final chat = _filteredChats[index];

                          return Dismissible(
                            key: ValueKey(chat.id),
                            direction: DismissDirection.endToStart,

                            background: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(18),
                              ),
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.only(right: 24),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),

                            onDismissed: (_) {
                              _deleteChat(chat);
                            },

                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              child: Card(
                                color: const Color(0xff1A1A1A),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(18),
                                ),
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor:
                                        Color(0xff2B2B2B),
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
                                    DateFormat("dd MMM")
                                        .format(chat.updatedAt),
                                    style: const TextStyle(
                                      color: Colors.white38,
                                    ),
                                  ),

                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                          conversationId: chat.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}