import 'package:sqflite/sqflite.dart';

import '../features/chat/models/chat_message.dart';
import 'database_helper.dart';

class MessageRepository {
  final DatabaseHelper _helper = DatabaseHelper.instance;

  Future<void> insertMessage(ChatMessage message) async {
    final db = await _helper.database;

    await db.insert(
      'messages',
      message.toMap(),
    );
  }

  Future<List<ChatMessage>> getMessages(int conversationId) async {
    final db = await _helper.database;

    final maps = await db.query(
      'messages',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
      orderBy: 'timestamp ASC',
    );

    return maps.map((e) => ChatMessage.fromMap(e)).toList();
  }

  Future<void> deleteMessages(int conversationId) async {
    final db = await _helper.database;

    await db.delete(
      'messages',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
    );
  }
}