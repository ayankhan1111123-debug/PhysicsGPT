import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'physicsgpt.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDatabase,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('DROP TABLE IF EXISTS messages');

          await db.execute('''
          CREATE TABLE messages(
            id TEXT PRIMARY KEY,
            conversationId INTEGER NOT NULL,
            role TEXT NOT NULL,
            type TEXT NOT NULL,
            content TEXT NOT NULL,
            imagePath TEXT,
            pdfName TEXT,
            timestamp TEXT NOT NULL,
            status TEXT NOT NULL,
            FOREIGN KEY(conversationId)
            REFERENCES conversations(id)
            ON DELETE CASCADE
          )
          ''');
        }
      },
    );
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    await db.execute('''
    CREATE TABLE conversations(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      lastMessage TEXT NOT NULL,
      updatedAt TEXT NOT NULL,
      isFavorite INTEGER NOT NULL DEFAULT 0
    )
    ''');

    await db.execute('''
    CREATE TABLE messages(
      id TEXT PRIMARY KEY,
      conversationId INTEGER NOT NULL,
      role TEXT NOT NULL,
      type TEXT NOT NULL,
      content TEXT NOT NULL,
      imagePath TEXT,
      pdfName TEXT,
      timestamp TEXT NOT NULL,
      status TEXT NOT NULL,
      FOREIGN KEY(conversationId)
      REFERENCES conversations(id)
      ON DELETE CASCADE
    )
    ''');
  }
}