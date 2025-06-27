import 'dart:convert';

import 'package:hive/hive.dart';
part 'author.g.dart'; // Required for code generation

@HiveType(typeId: 1)
class Author {
  @HiveField(0)
  final String name;

  Author({required this.name});

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(name: json["name"]);
}
