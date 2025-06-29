import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'author.dart';
import 'formats.dart';

part 'book.g.dart';

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

  RxBool? isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.summaries,
    required this.subjects,
    required this.formats,
    this.isFavorite,
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
    isFavorite: false.obs,
  );

  Book copyWith({
    int? id,
    String? title,
    List<Author>? authors,
    List<String>? summaries,
    List<String>? subjects,
    Formats? formats,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      summaries: summaries ?? this.summaries,
      subjects: subjects ?? this.subjects,
      formats: formats ?? this.formats,
      isFavorite: isFavorite?.obs ?? this.isFavorite,
    );
  }
}

extension BookRxExtension on Book {
  void rehydrateFavorite({required bool value}) {
    isFavorite = value.obs;
  }
}
