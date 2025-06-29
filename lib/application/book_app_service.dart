import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:palm_code_arman/domain/interface/book_local_interface.dart';
import 'package:palm_code_arman/domain/interface/book_remote_interface.dart';
import 'package:palm_code_arman/domain/models/book.dart';
import 'package:palm_code_arman/domain/models/books_response.dart';
import 'package:palm_code_arman/infrastructure/book_local_data_source.dart';
import 'package:palm_code_arman/infrastructure/book_remote_data_source.dart';

class BookAppService {
  final BookRemoteInterface _remote = BookRemoteDataSource();
  final BookLocalInterface _local = BookLocalDataSource();

  // Remote book data
  Future<Either<HttpException, BooksResponse>> getBooks({String? url}) async {
    final endpoint = url ?? "https://gutendex.com/books/?page=1";
    final result = await _remote.getBooks(endpoint);

    return result.fold((l) => Left(l), (response) {
      // only store the cached data from the page 1
      if (url == null) _local.storeCacheBooks(books: response.results);
      return Right(response);
    });
  }

  Future<Either<HttpException, BooksResponse>> searchBook(String search) =>
      _remote.searchBooks(search);

  // Local cached books
  Future<List<Book>> loadCachedBooks() => _local.loadCachedBooks();
  void storeCacheBooks({required List<Book> books}) =>
      _local.storeCacheBooks(books: books);

  // Favorite books
  Future<List<Book>> getFavoriteBooks() => _local.getFavoriteBooks();
  void addFavoriteBook({required Book book}) =>
      _local.addFavoriteBook(book: book);
  void removeFavoriteBook({required Book book}) =>
      _local.removeFavoriteBook(book: book);
}
