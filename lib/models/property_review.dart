import 'dart:convert';

import 'package:flutter/foundation.dart';

class PropertyReview {
  final String propertyId;
  final double reviews;
  final List<String> reviewProviderIds;
  PropertyReview({
    required this.propertyId,
    required this.reviews,
    required this.reviewProviderIds,
  });

  PropertyReview copyWith({
    String? propertyId,
    double? reviews,
    List<String>? reviewProviderIds,
  }) {
    return PropertyReview(
      propertyId: propertyId ?? this.propertyId,
      reviews: reviews ?? this.reviews,
      reviewProviderIds: reviewProviderIds ?? this.reviewProviderIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'propertyId': propertyId,
      'reviews': reviews,
      'reviewProviderIds': reviewProviderIds,
    };
  }

  factory PropertyReview.fromMap(Map<String, dynamic> map) {
    return PropertyReview(
      propertyId: map['propertyId'] ?? '',
      reviews: map['reviews']?.toDouble() ?? 0.0,
      reviewProviderIds: List<String>.from(map['reviewProviderIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyReview.fromJson(String source) =>
      PropertyReview.fromMap(json.decode(source));

  @override
  String toString() =>
      'PropertyReview(propertyId: $propertyId, reviews: $reviews, reviewProviderIds: $reviewProviderIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PropertyReview &&
        other.propertyId == propertyId &&
        other.reviews == reviews &&
        listEquals(other.reviewProviderIds, reviewProviderIds);
  }

  @override
  int get hashCode =>
      propertyId.hashCode ^ reviews.hashCode ^ reviewProviderIds.hashCode;
}
