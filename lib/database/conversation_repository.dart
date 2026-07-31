import 'package:sqflite/sqflite.dart';

import 'conversation.dart';
import 'database_helper.dart';

class ConversationRepository {
  final DatabaseHelper _helper = DatabaseHelper.instance;

  Future<int> insertConversation(
    Conversation conversation,
  ) async {
    final Database db = await _helper.database;

    return await db.insert(
      'conversations',
      conversation.toMap(),
    );
  }

  Future<List<Conversation>> getConversations() async {
    final Database db = await _helper.database;

    final List<Map<String, dynamic>> maps =
        await db.query(
      'conversations',
      orderBy: 'updatedAt DESC',
    );

    return maps
        .map((e) => Conversation.fromMap(e))
        .toList();
  }

  Future<void> deleteConversation(
    int id,
  ) async {
    final Database db = await _helper.database;

    await db.delete(
      'conversations',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}