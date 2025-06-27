import 'package:get/get.dart';
import 'package:palm_code_arman/application/book_app_service.dart';
import 'package:palm_code_arman/presentation/home/home_state.dart';

class HomeLogic extends GetxController {
  HomeState state = HomeState();
  final BookAppService _bookAppService = BookAppService();

  @override
  void onInit() {
    getBooks();
    state.scrollController.addListener(_onScroll);
    super.onInit();
  }

  void getBooks() async {
    state.isLoading.value = true;
    final data = await _bookAppService.getBooks();
    state.isLoading.value = false;
    data.fold((l) => Get.log("ada error nih bos $l"), (r) {
      state.books.addAll(r.results);
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
}
