import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/application/book_app_service.dart';
import 'package:palm_code_arman/domain/models/book.dart';
import 'package:palm_code_arman/presentation/home/home_state.dart';
import 'package:palm_code_arman/presentation/widgets/error_snackbar.dart';

class HomeLogic extends GetxController {
  HomeState state = HomeState();
  final BookAppService _bookAppService = BookAppService();
  Timer? _debounce;

  @override
  void onInit() {
    getFavoriteBook();
    // 1. get the local books as a initial data
    getLocalBooks();
    // 2. get the actual books data from the API
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

  void getLocalBooks() async {
    final data = await _bookAppService.loadCachedBooks();
    state.books.assignAll(data);
    state.isLoading.value = false;
  }

  void getBooks() async {
    final data = await _bookAppService.getBooks();
    state.isLoading.value = false;
    data.fold(
      (l) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(errorSnackbar(errorText: "Error, ${l.message}"));
        state.isErrorFetch.value = true;
      },
      (r) {
        state.isErrorFetch.value = false;
        state.books.assignAll(r.results);
        state.nextPageUrl = r.next;
      },
    );
  }

  void getMoreBook({String? url}) async {
    state.isLoadingMore.value = true;
    final data = await _bookAppService.getBooks(url: url);
    state.isLoadingMore.value = false;
    data.fold(
      (l) {
        state.isErrorFetchMore.value = true;
      },
      (r) {
        state.isErrorFetchMore.value = false;
        state.books.addAll(r.results);
        state.nextPageUrl = r.next;
      },
    );
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
      if (value == null || value.trim().isEmpty) return getBooks();

      state.search.value = value;
      state.isLoading.value = true;

      final data = await _bookAppService.searchBook(value);

      state.isLoading.value = false;
      data.fold(
        (l) => ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(errorSnackbar(errorText: "Error, ${l.message}")),
        (r) {
          state.books.assignAll(r.results);
          state.nextPageUrl = r.next;
        },
      );
    });
  }

  void onClearSearch() {
    state.searchController.text = "";
    state.search.value = "";
    getBooks();
  }

  void getFavoriteBook() async {
    final data = await _bookAppService.getFavoriteBooks();
    state.favorites.assignAll(data);
  }

  void favoriteBookAction(Book book) {
    final isAlreadyFavorite = state.favorites.any((f) => f.id == book.id);

    if (isAlreadyFavorite) {
      state.favorites.removeWhere((f) => f.id == book.id);
      book.isFavorite?.value = false;
      _bookAppService.removeFavoriteBook(book: book);
    } else {
      state.favorites.add(book);
      book.isFavorite?.value = true;
      _bookAppService.addFavoriteBook(book: book);
    }

    book.isFavorite?.refresh();
    state.favorites.refresh();
  }
}
