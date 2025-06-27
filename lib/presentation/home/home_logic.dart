import 'dart:async';

import 'package:get/get.dart';
import 'package:palm_code_arman/application/book_app_service.dart';
import 'package:palm_code_arman/presentation/home/home_state.dart';

class HomeLogic extends GetxController {
  HomeState state = HomeState();
  final BookAppService _bookAppService = BookAppService();
  Timer? _debounce;

  @override
  void onInit() {
    getBooks();
    state.scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    state.scrollController.dispose();
    state.searchController.dispose();
    super.onClose();
  }

  void getBooks() async {
    state.isLoading.value = true;
    final data = await _bookAppService.getBooks();
    state.isLoading.value = false;
    data.fold((l) => Get.log("ada error nih bos $l"), (r) {
      state.books.assignAll(r.results);
      state.nextPageUrl = r.next;
    });
  }

  void getMoreBook({String? url}) async {
    state.isLoadingMore.value = true;
    final data = await _bookAppService.getBooks(url: url);
    state.isLoadingMore.value = false;
    data.fold((l) => Get.log("ada error nih bos $l"), (r) {
      state.books.addAll(r.results);
      state.nextPageUrl = r.next;
    });
  }

  void _onScroll() {
    if (state.scrollController.position.pixels >=
        state.scrollController.position.maxScrollExtent - 300) {
      if (!state.isLoadingMore.value && state.nextPageUrl != null) {
        getMoreBook(url: state.nextPageUrl);
      }
    }
  }

  void searchBooks(String? value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value == null || value.trim().isEmpty) return;

      state.search.value = value;
      state.isLoading.value = true;

      final data = await _bookAppService.searchBook(value);

      state.isLoading.value = false;
      data.fold((l) => Get.log("ada error nih bos $l"), (r) {
        state.books.assignAll(r.results);
        state.nextPageUrl = r.next;
      });
    });
  }

  void onClearSearch() {
    state.searchController.text = "";
    state.search.value = "";
    getBooks();
  }
}
