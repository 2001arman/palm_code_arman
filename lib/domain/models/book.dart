import 'dart:convert';
import 'package:hive/hive.dart';
import 'author.dart'; // Make sure Author is also a HiveObject
import 'formats.dart'; // Make sure Formats is also a HiveObject

part 'book.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Author> authors;

  @HiveField(3)
  List<String> summaries;

  @HiveField(4)
  List<String> subjects;

  @HiveField(5)
  Formats formats;

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



