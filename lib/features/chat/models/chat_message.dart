import 'dart:io';

enum MessageRole {
  user,
  assistant,
  system,
}

enum MessageType {
  text,
  image,
  pdf,
}

enum MessageStatus {
  sending,
  sent,
  error,
}

class ChatMessage {
  final String id;

  /// Nullable until saved into SQLite
  final int? conversationId;

  final MessageRole role;

  final MessageType type;

  final String content;

  final File? imageFile;

  final String? pdfName;

  final DateTime timestamp;

  final MessageStatus status;

  const ChatMessage({
    required this.id,
    this.conversationId,
    required this.role,
    required this.type,
    required this.content,
    this.imageFile,
    this.pdfName,
    required this.timestamp,
    this.status = MessageStatus.sent,
  });

  ChatMessage copyWith({
    String? id,
    int? conversationId,
    MessageRole? role,
    MessageType? type,
    String? content,
    File? imageFile,
    String? pdfName,
    DateTime? timestamp,
    MessageStatus? status,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      type: type ?? this.type,
      content: content ?? this.content,
      imageFile: imageFile ?? this.imageFile,
      pdfName: pdfName ?? this.pdfName,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "conversationId": conversationId,
      "role": role.name,
      "type": type.name,
      "content": content,
      "imagePath": imageFile?.path,
      "pdfName": pdfName,
      "timestamp": timestamp.toIso8601String(),
      "status": status.name,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map["id"].toString(),
      conversationId: map["conversationId"],
      role: MessageRole.values.firstWhere(
        (e) => e.name == map["role"],
      ),
      type: MessageType.values.firstWhere(
        (e) => e.name == map["type"],
      ),
      content: map["content"] ?? "",
      imageFile: map["imagePath"] != null
          ? File(map["imagePath"])
          : null,
      pdfName: map["pdfName"],
      timestamp: DateTime.parse(map["timestamp"]),
      status: MessageStatus.values.firstWhere(
        (e) => e.name == map["status"],
        orElse: () => MessageStatus.sent,
      ),
    );
  }
}