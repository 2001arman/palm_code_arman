import 'package:hive/hive.dart';
import 'package:palm_code_arman/domain/interface/book_local_interface.dart';
import 'package:palm_code_arman/domain/models/book.dart';

class BookLocalDataSource implements BookLocalInterface {
  final String _cacheBox = 'book_cache';
  final String _favoriteBox = 'favorite_book';

  @override
  Future<List<Book>> loadCachedBooks() async {
    var box = await Hive.openBox<Book>(_cacheBox);
    final books = box.values.toList();

    for (var book in books) {
      book.rehydrateFavorite(value: false);
    }

    return books;
  }

  @override
  void storeCacheBooks({required List<Book> books}) async {
    var box = await Hive.openBox<Book>(_cacheBox);

    // Update or insert new files from API
    for (var file in books) {
      await box.put(file.id, file); // insert and update
    }
  }

  @override
  Future<List<Book>> getFavoriteBooks() async {
    var box = await Hive.openBox<Book>(_favoriteBox);
    final books = box.values.toList();

    for (var book in books) {
      book.rehydrateFavorite(value: true);
    }

    return books;
  }

  @override
  void addFavoriteBook({required Book book}) async {
    var box = await Hive.openBox<Book>(_favoriteBox);

    await box.put(
      book.id,
      book.copyWith(isFavorite: true),
    ); // insert and update
  }

  @override
  void removeFavoriteBook({required Book book}) async {
    var box = await Hive.openBox<Book>(_favoriteBox);

    await box.delete(book.id); // insert and update
  }
}
