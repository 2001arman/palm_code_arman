import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
  }
}
