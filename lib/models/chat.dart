import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chat {
  final String id;
  final String tenantID;
  final String proprietorID;
  final String propertyID;
  final List<Map<String, String>> chat;
  Chat({
    required this.id,
    required this.tenantID,
    required this.proprietorID,
    required this.propertyID,
    required this.chat,
  });

  Chat copyWith({
    String? id,
    String? tenantID,
    String? proprietorID,
    String? propertyID,
    List<Map<String, String>>? chat,
  }) {
    return Chat(
      id: id ?? this.id,
      tenantID: tenantID ?? this.tenantID,
      proprietorID: proprietorID ?? this.proprietorID,
      propertyID: propertyID ?? this.propertyID,
      chat: chat ?? this.chat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tenantID': tenantID,
      'proprietorID': proprietorID,
      'propertyID': propertyID,
      'chat': chat,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] ?? '',
      tenantID: map['tenantID'] ?? '',
      proprietorID: map['proprietorID'] ?? '',
      propertyID: map['propertyID'] ?? '',
      chat: List<Map<String, String>>.from(
        map['chat']?.map((x) => Map<String, String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chat(id: $id, tenantID: $tenantID, proprietorID: $proprietorID, propertyID: $propertyID, chat: $chat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.tenantID == tenantID &&
        other.proprietorID == proprietorID &&
        other.propertyID == propertyID &&
        listEquals(other.chat, chat);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tenantID.hashCode ^
        proprietorID.hashCode ^
        propertyID.hashCode ^
        chat.hashCode;
  }
}
