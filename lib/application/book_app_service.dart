import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:palm_code_arman/domain/interface/book_remote_interface.dart';
import 'package:palm_code_arman/domain/models/books_response.dart';
import 'package:palm_code_arman/infrastructure/book_remote_data_source.dart';

class BookAppService {
  BookRemoteInterface bookRemoteData = BookRemoteDataSource();

  Future<Either<HttpException, BooksResponse>> getBooks({String? url}) =>
      bookRemoteData.getBooks(url ?? "https://gutendex.com/books/?page=1");
}
