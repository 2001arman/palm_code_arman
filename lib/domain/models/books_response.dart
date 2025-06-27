import 'dart:convert';

class BooksResponse {
  final int count;
  final String next;
  final List<Result> results;

  BooksResponse({
    required this.count,
    required this.next,
    required this.results,
  });

  factory BooksResponse.fromRawJson(String str) =>
      BooksResponse.fromJson(json.decode(str));

  factory BooksResponse.fromJson(Map<String, dynamic> json) => BooksResponse(
    count: json["count"],
    next: json["next"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );
}

class Result {
  final int id;
  final String title;
  final List<Author> authors;
  final List<String> summaries;
  final List<Author> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final String mediaType;
  final int downloadCount;
  final Formats formats;

  Result({
    required this.id,
    required this.title,
    required this.authors,
    required this.summaries,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.downloadCount,
    required this.formats,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    summaries: List<String>.from(json["summaries"].map((x) => x)),
    translators: List<Author>.from(
      json["translators"].map((x) => Author.fromJson(x)),
    ),
    subjects: List<String>.from(json["subjects"].map((x) => x)),
    bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
    languages: List<String>.from(json["languages"].map((x) => x)),
    copyright: json["copyright"],
    mediaType: json["media_type"],
    downloadCount: json["download_count"],
    formats: Formats.fromJson(json["formats"]),
  );
}

class Author {
  final String name;
  final int birthYear;
  final int deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    birthYear: json["birth_year"],
    deathYear: json["death_year"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "birth_year": birthYear,
    "death_year": deathYear,
  };
}

class Formats {
  final String imageJpeg;

  Formats({required this.imageJpeg});

  factory Formats.fromRawJson(String str) => Formats.fromJson(json.decode(str));

  factory Formats.fromJson(Map<String, dynamic> json) =>
      Formats(imageJpeg: json["image/jpeg"]);
}
