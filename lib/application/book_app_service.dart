import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:palm_code_arman/domain/interface/book_local_interface.dart';
import 'package:palm_code_arman/domain/interface/book_remote_interface.dart';
import 'package:palm_code_arman/domain/models/book.dart';
import 'package:palm_code_arman/domain/models/books_response.dart';
import 'package:palm_code_arman/infrastructure/book_local_data_source.dart';
import 'package:palm_code_arman/infrastructure/book_remote_data_source.dart';

class BookAppService {
  final BookRemoteInterface _bookRemoteData = BookRemoteDataSource();
  final BookLocalInterface _bookLocalData = BookLocalDataSource();

  // remote book data module
  Future<Either<HttpException, BooksResponse>> getBooks({String? url}) async {
    final data = await _bookRemoteData.getBooks(
      url ?? "https://gutendex.com/books/?page=1",
    );
    return data.fold((l) => Left(l), (r) {
      // store loaded books to local data
      // storeCacheBooks(books: r.results);
      return Right(r);
    });
  }

  Future<Either<HttpException, BooksResponse>> searchBook(String search) =>
      _bookRemoteData.searchBooks(search);

  // cached local books module
  Future<List<Book>> loadCachedBooks() => _bookLocalData.loadCachedBooks();
  void storeCacheBooks({required List<Book> books}) =>
      _bookLocalData.storeCacheBooks(books: books);

  // favorite module
  Future<List<Book>> getFavoriteBooks() => _bookLocalData.getFavoriteBooks();
  void addFavoriteBook({required Book book}) =>
      _bookLocalData.addFavoriteBook(book: book);
  void removeFavoriteBook({required Book book}) =>
      _bookLocalData.removeFavoriteBook(book: book);
}
