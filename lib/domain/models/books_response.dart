import 'dart:convert';

class BooksResponse {
  final int count;
  final String? next;
  final List<Book> results;

  BooksResponse({required this.count, this.next, required this.results});

  factory BooksResponse.fromRawJson(String str) =>
      BooksResponse.fromJson(json.decode(str));

  factory BooksResponse.fromJson(Map<String, dynamic> json) => BooksResponse(
    count: json["count"],
    next: json["next"],
    results: List<Book>.from(json["results"].map((x) => Book.fromJson(x))),
  );
}

class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final List<String> summaries;
  final List<String> subjects;
  final Formats formats;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.summaries,
    required this.subjects,
    required this.formats,
  });

  String get authorName {
    if (authors.isEmpty) return 'Unknown';
    return authors.map((a) => a.name).join(' - ');
  }

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    title: json["title"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    summaries: List<String>.from(json["summaries"].map((x) => x)),
    subjects: List<String>.from(json["subjects"].map((x) => x)),
    formats: Formats.fromJson(json["formats"]),
  );
}

class Author {
  final String name;

  Author({required this.name});

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(name: json["name"]);
}

class Formats {
  final String imageJpeg;

  Formats({required this.imageJpeg});

  factory Formats.fromRawJson(String str) => Formats.fromJson(json.decode(str));

  factory Formats.fromJson(Map<String, dynamic> json) =>
      Formats(imageJpeg: json["image/jpeg"]);
}
