import 'dart:async';

import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_state.dart';

class FavoriteLogic extends GetxController {
  FavoriteState state = FavoriteState();
  Timer? _debounce;

  void searchBooks(String? value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value == null || value.trim().isEmpty) return;

      state.search.value = value;
      state.isLoading.value = true;

      // final data = await _bookAppService.searchBook(value);

      state.isLoading.value = false;
      // data.fold((l) => Get.log("ada error nih bos $l"), (r) {
      //   state.books.assignAll(r.results);
      // });
    });
  }

  void onClearSearch() {
    state.searchController.text = "";
    state.search.value = "";
  }
}
