import 'package:get/get.dart';
import 'package:palm_code_arman/domain/models/book.dart';

class DetailLogic extends GetxController {
  late final Book book;

  @override
  void onInit() {
    book = Get.arguments;
    super.onInit();
  }
}
