import 'dart:convert';

import 'package:palm_code_arman/domain/models/book.dart';

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
