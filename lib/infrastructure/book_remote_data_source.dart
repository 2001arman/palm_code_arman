import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:palm_code_arman/domain/interface/book_remote_interface.dart';
import 'package:palm_code_arman/domain/models/books_response.dart';

class BookRemoteDataSource implements BookRemoteInterface {
  @override
  Future<Either<HttpException, BooksResponse>> getBooks(String url) async {
    try {
      final pageUrl = Uri.parse(url);

      final response = await http.get(pageUrl);

      if (response.statusCode == 200) {
        return Right(BooksResponse.fromRawJson(response.body));
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } on HttpException catch (e) {
      return Left(e);
    }
  }
}
