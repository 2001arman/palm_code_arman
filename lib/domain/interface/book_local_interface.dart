import 'package:palm_code_arman/domain/models/book.dart';

abstract class BookLocalInterface {
  Future<List<Book>> loadCachedBooks();
  void storeCacheBooks({required List<Book> books});
}
