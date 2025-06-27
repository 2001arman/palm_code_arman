import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:palm_code_arman/domain/interface/book_remote_interface.dart';
import 'package:palm_code_arman/domain/models/books_response.dart';

class BookRemoteDataSource implements BookRemoteInterface {
  final http.Client client;

  BookRemoteDataSource({http.Client? client})
    : client = client ?? http.Client();

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
    } on http.ClientException catch (e) {
      return Left(HttpException(e.message));
    } catch (e) {
      return Left(HttpException(e.toString()));
    }
  }

  @override
  Future<Either<HttpException, BooksResponse>> searchBooks(
    String search,
  ) async {
    try {
      final pageUrl = Uri.parse("https://gutendex.com/books?search=$search");

      final response = await http.get(pageUrl);

      if (response.statusCode == 200) {
        return Right(BooksResponse.fromRawJson(response.body));
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } on HttpException catch (e) {
      return Left(e);
    } on http.ClientException catch (e) {
      return Left(HttpException(e.message));
    } catch (e) {
      return Left(HttpException(e.toString()));
    }
  }
}
