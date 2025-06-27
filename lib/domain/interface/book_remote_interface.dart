import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:palm_code_arman/domain/models/books_response.dart';

abstract class BookRemoteInterface {
  Future<Either<HttpException, BooksResponse>> getBooks(String url);
  Future<Either<HttpException, BooksResponse>> searchBooks(String search);
}
