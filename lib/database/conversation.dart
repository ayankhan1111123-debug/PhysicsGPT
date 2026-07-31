class Conversation {
  final int? id;
  final String title;
  final String lastMessage;
  final DateTime updatedAt;
  final bool isFavorite;

  const Conversation({
    this.id,
    required this.title,
    required this.lastMessage,
    required this.updatedAt,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'lastMessage': lastMessage,
      'updatedAt': updatedAt.toIso8601String(),
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'],
      title: map['title'],
      lastMessage: map['lastMessage'],
      updatedAt: DateTime.parse(map['updatedAt']),
      isFavorite: map['isFavorite'] == 1,
    );
  }
}