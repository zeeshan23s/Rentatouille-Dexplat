import 'dart:convert';

import 'package:flutter/foundation.dart';

class PropertyRent {
  final String propertyId;
  final String proprietorId;
  final String tenantId;
  final List<Map<String, dynamic>> rentHistory;
  PropertyRent({
    required this.propertyId,
    required this.proprietorId,
    required this.tenantId,
    required this.rentHistory,
  });

  PropertyRent copyWith({
    String? propertyId,
    String? proprietorId,
    String? tenantId,
    List<Map<String, dynamic>>? rentHistory,
  }) {
    return PropertyRent(
      propertyId: propertyId ?? this.propertyId,
      proprietorId: proprietorId ?? this.proprietorId,
      tenantId: tenantId ?? this.tenantId,
      rentHistory: rentHistory ?? this.rentHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'propertyId': propertyId,
      'proprietorId': proprietorId,
      'tenantId': tenantId,
      'rentHistory': rentHistory,
    };
  }

  factory PropertyRent.fromMap(Map<String, dynamic> map) {
    return PropertyRent(
      propertyId: map['propertyId'] ?? '',
      proprietorId: map['proprietorId'] ?? '',
      tenantId: map['tenantId'] ?? '',
      rentHistory: List<Map<String, dynamic>>.from(
          map['rentHistory']?.map((x) => Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyRent.fromJson(String source) =>
      PropertyRent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PropertyRent(propertyId: $propertyId, proprietorId: $proprietorId, tenantId: $tenantId, rentHistory: $rentHistory)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PropertyRent &&
        other.propertyId == propertyId &&
        other.proprietorId == proprietorId &&
        other.tenantId == tenantId &&
        listEquals(other.rentHistory, rentHistory);
  }

  @override
  int get hashCode {
    return propertyId.hashCode ^
        proprietorId.hashCode ^
        tenantId.hashCode ^
        rentHistory.hashCode;
  }
}
