import 'package:hive/hive.dart';
import 'package:palm_code_arman/domain/models/author.dart';
import 'package:palm_code_arman/domain/models/book.dart';
import 'package:palm_code_arman/domain/models/formats.dart';
import 'package:path_provider/path_provider.dart';

class HiveBinding {
  static Future<void> initModel() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(FormatsAdapter());
    Hive.registerAdapter(AuthorAdapter());
  }
}
