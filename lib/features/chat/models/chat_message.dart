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

  final MessageRole role;

  final MessageType type;

  final String content;

  final DateTime timestamp;

  final File? imageFile;

  final File? pdfFile;

  final String? pdfName;

  final bool isFavorite;

  final MessageStatus status;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.type,
    required this.content,
    required this.timestamp,
    this.imageFile,
    this.pdfFile,
    this.pdfName,
    this.isFavorite = false,
    this.status = MessageStatus.sent,
  });

  ChatMessage copyWith({
    String? id,
    MessageRole? role,
    MessageType? type,
    String? content,
    DateTime? timestamp,
    File? imageFile,
    File? pdfFile,
    String? pdfName,
    bool? isFavorite,
    MessageStatus? status,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      type: type ?? this.type,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      imageFile: imageFile ?? this.imageFile,
      pdfFile: pdfFile ?? this.pdfFile,
      pdfName: pdfName ?? this.pdfName,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }
}