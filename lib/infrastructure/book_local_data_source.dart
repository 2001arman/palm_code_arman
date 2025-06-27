import 'package:hive/hive.dart';
import 'package:palm_code_arman/domain/interface/book_local_interface.dart';
import 'package:palm_code_arman/domain/models/book.dart';

class BookLocalDataSource implements BookLocalInterface {
  final String _cacheBox = 'book_cache';

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
}
