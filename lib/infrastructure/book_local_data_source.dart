import 'package:hive/hive.dart';
import 'package:palm_code_arman/domain/interface/book_local_interface.dart';
import 'package:palm_code_arman/domain/models/book.dart';

class BookLocalDataSource implements BookLocalInterface {
  final String _cacheBox = 'book_cache';
  final String _favoriteBox = 'favorite_book';

  @override
  Future<List<Book>> loadCachedBooks() async {
    var box = await Hive.openBox<Book>(_cacheBox);

    return box.values.toList();
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

    return box.values.toList();
  }

  @override
  void addFavoriteBook({required Book book}) async {
    var box = await Hive.openBox<Book>(_favoriteBox);

    await box.put(book.id, book); // insert and update
  }

  @override
  void removeFavoriteBook({required Book book}) async {
    var box = await Hive.openBox<Book>(_favoriteBox);

    await box.delete(book.id); // insert and update
  }
}
