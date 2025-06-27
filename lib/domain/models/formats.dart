import 'dart:convert';

import 'package:hive/hive.dart';
part 'formats.g.dart'; // Required for code generation

@HiveType(typeId: 2)
class Formats {
  @HiveField(0)
  final String imageJpeg;

  Formats({required this.imageJpeg});

  factory Formats.fromRawJson(String str) => Formats.fromJson(json.decode(str));

  factory Formats.fromJson(Map<String, dynamic> json) =>
      Formats(imageJpeg: json["image/jpeg"]);
}
