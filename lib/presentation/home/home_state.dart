import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/domain/models/book.dart';

class HomeState {
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxString search = ''.obs;

  RxList<Book> books = <Book>[].obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isErrorFetch = false.obs;
  RxBool isErrorFetchMore = false.obs;
  String? nextPageUrl;
}
