import 'dart:convert';

class AppUser {
  final String id;
  final String name;
  final String? imageURL;
  final String email;
  final String phoneNumber;
  final String address;
  AppUser({
    required this.id,
    required this.name,
    this.imageURL,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? imageURL,
    String? email,
    String? phoneNumber,
    String? address,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      imageURL: imageURL ?? this.imageURL,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageURL': imageURL,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageURL: map['imageURL'],
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, imageURL: $imageURL, email: $email, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.name == name &&
        other.imageURL == imageURL &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageURL.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode;
  }
}
