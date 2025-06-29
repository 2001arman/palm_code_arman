import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/application/book_app_service.dart';
import 'package:palm_code_arman/domain/models/book.dart';
import 'package:palm_code_arman/presentation/home/home_state.dart';
import 'package:palm_code_arman/presentation/widgets/error_snackbar.dart';

class HomeLogic extends GetxController {
  final state = HomeState();
  final BookAppService _bookAppService = BookAppService();
  Timer? _debounce;

  @override
  void onInit() {
    getFavoriteBooks();
    super.onInit();
  }

  @override
  void onReady() async {
    await getLocalBooks(); // get local cache first
    getBooks(); // remote fetch
    state.scrollController.addListener(_onScroll);
    super.onReady();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    state.scrollController.dispose();
    state.searchController.dispose();
    super.onClose();
  }

  Future<void> getLocalBooks() async {
    final cached = await _bookAppService.loadCachedBooks();
    state.books.assignAll(cached);
  }

  void getBooks() async {
    final result = await _bookAppService.getBooks();
    state.isLoading.value = false;

    result.fold(
      (error) {
        _showError("Error, ${error.message}");

        if (state.books.isEmpty) {
          state.isErrorFetch.value = true;
        } else {
          state.isErrorFetchMore.value = true;
        }
      },
      (response) {
        state
          ..isErrorFetch.value = false
          ..books.assignAll(response.results)
          ..nextPageUrl = response.next;
      },
    );
  }

  void getMoreBook({String? url}) async {
    state.isLoadingMore.value = true;
    final result = await _bookAppService.getBooks(url: url);
    state.isLoadingMore.value = false;

    result.fold((_) => state.isErrorFetchMore.value = true, (response) {
      state
        ..isErrorFetchMore.value = false
        ..books.addAll(response.results)
        ..nextPageUrl = response.next;
    });
  }

  void _onScroll() {
    if (state.scrollController.position.pixels >=
            state.scrollController.position.maxScrollExtent - 300 &&
        !state.isLoadingMore.value &&
        state.nextPageUrl != null) {
      getMoreBook(url: state.nextPageUrl);
    }
  }

  void searchBooks(String? value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value == null || value.trim().isEmpty) {
        getBooks();
        return;
      }

      state
        ..search.value = value
        ..isLoading.value = true;

      final result = await _bookAppService.searchBook(value);
      state.isLoading.value = false;

      result.fold((error) => _showError("Error, ${error.message}"), (response) {
        state
          ..books.assignAll(response.results)
          ..nextPageUrl = response.next;
      });
    });
  }

  void onClearSearch() {
    state
      ..searchController.clear()
      ..search.value = "";
    getBooks();
  }

  void getFavoriteBooks() async {
    final favorites = await _bookAppService.getFavoriteBooks();
    state.favorites.assignAll(favorites);
  }

  void favoriteBookAction(Book book) {
    final isFavorite = state.favorites.any((f) => f.id == book.id);

    if (isFavorite) {
      state.favorites.removeWhere((f) => f.id == book.id);
      _bookAppService.removeFavoriteBook(book: book);
      book.isFavorite?.value = false;
    } else {
      state.favorites.add(book);
      _bookAppService.addFavoriteBook(book: book);
      book.isFavorite?.value = true;
    }

    book.isFavorite?.refresh();
    state.favorites.refresh();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(errorSnackbar(errorText: message));
  }
}
