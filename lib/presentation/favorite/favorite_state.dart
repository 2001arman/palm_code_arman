import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/domain/models/book.dart';

class FavoriteState {
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxString search = ''.obs;

  RxList<Book> books = <Book>[].obs;
  RxBool isLoading = false.obs;
}
