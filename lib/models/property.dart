import 'dart:convert';
import 'package:flutter/foundation.dart';

class Property {
  final String id;
  final String title;
  final String description;
  final List<dynamic> imagesURL;
  final int bedrooms;
  final int area;
  final int monthlyRent;
  final String address;
  final bool hasLounge;
  final String uploadByUser;
  final bool isSold;
  final String? buyerId;
  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.imagesURL,
    required this.bedrooms,
    required this.area,
    required this.monthlyRent,
    required this.address,
    required this.hasLounge,
    required this.uploadByUser,
    required this.isSold,
    this.buyerId,
  });

  Property copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? imagesURL,
    int? bedrooms,
    int? area,
    int? monthlyRent,
    String? address,
    bool? hasLounge,
    String? uploadByUser,
    bool? isSold,
    String? buyerId,
  }) {
    return Property(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagesURL: imagesURL ?? this.imagesURL,
      bedrooms: bedrooms ?? this.bedrooms,
      area: area ?? this.area,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      address: address ?? this.address,
      hasLounge: hasLounge ?? this.hasLounge,
      uploadByUser: uploadByUser ?? this.uploadByUser,
      isSold: isSold ?? this.isSold,
      buyerId: buyerId ?? this.buyerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagesURL': imagesURL,
      'bedrooms': bedrooms,
      'area': area,
      'monthlyRent': monthlyRent,
      'address': address,
      'hasLounge': hasLounge,
      'uploadByUser': uploadByUser,
      'isSold': isSold,
      'buyerId': buyerId,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imagesURL: List<String>.from(map['imagesURL']),
      bedrooms: map['bedrooms']?.toInt() ?? 0,
      area: map['area']?.toInt() ?? 0,
      monthlyRent: map['monthlyRent']?.toInt() ?? 0,
      address: map['address'] ?? '',
      hasLounge: map['hasLounge'] ?? false,
      uploadByUser: map['uploadByUser'] ?? '',
      isSold: map['isSold'] ?? false,
      buyerId: map['buyerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Property(id: $id, title: $title, description: $description, imagesURL: $imagesURL, bedrooms: $bedrooms, area: $area, monthlyRent: $monthlyRent, address: $address, hasLounge: $hasLounge, uploadByUser: $uploadByUser, isSold: $isSold, buyerId: $buyerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Property &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.imagesURL, imagesURL) &&
        other.bedrooms == bedrooms &&
        other.area == area &&
        other.monthlyRent == monthlyRent &&
        other.address == address &&
        other.hasLounge == hasLounge &&
        other.uploadByUser == uploadByUser &&
        other.isSold == isSold &&
        other.buyerId == buyerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imagesURL.hashCode ^
        bedrooms.hashCode ^
        area.hashCode ^
        monthlyRent.hashCode ^
        address.hashCode ^
        hasLounge.hashCode ^
        uploadByUser.hashCode ^
        isSold.hashCode ^
        buyerId.hashCode;
  }
}
