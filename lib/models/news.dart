import 'dart:convert';

class News {
  final String title;
  final String description;
  final String? urlToImage;
  final String url;
  News({
    required this.title,
    required this.description,
    this.urlToImage,
    required this.url,
  });

  News copyWith({
    String? title,
    String? description,
    String? urlToImage,
    String? url,
  }) {
    return News(
      title: title ?? this.title,
      description: description ?? this.description,
      urlToImage: urlToImage ?? this.urlToImage,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'url': url,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      urlToImage: map['urlToImage'],
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  String toString() {
    return 'News(title: $title, description: $description, urlToImage: $urlToImage, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is News &&
        other.title == title &&
        other.description == description &&
        other.urlToImage == urlToImage &&
        other.url == url;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        urlToImage.hashCode ^
        url.hashCode;
  }
}
