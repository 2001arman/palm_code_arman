import 'package:palm_code_arman/domain/models/book.dart';

abstract class BookLocalInterface {
  Future<List<Book>> loadCachedBooks();
  void storeCacheBooks({required List<Book> books});

  Future<List<Book>> getFavoriteBooks();
  void addFavoriteBook({required Book book});
  void removeFavoriteBook({required Book book});
}
